import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:rx_scan/main.dart';

class Questionaire extends StatefulWidget {
  const Questionaire({super.key});

  @override
  State<Questionaire> createState() => _QuestionaireState();
}

class _QuestionaireState extends State<Questionaire> {
  Future<Task> _getTask() {
    var nameStep = QuestionStep(
        stepIdentifier: StepIdentifier(),
        title: 'Medication',
        answerFormat:
            const TextAnswerFormat(hint: 'Enter the name of your medication'));

    var doseStep = QuestionStep(
      stepIdentifier: StepIdentifier(),
      title: 'Dosage',
      answerFormat:
          const TextAnswerFormat(hint: 'Enter the dosage of your medication'),
    );

    var timeStep = QuestionStep(
      stepIdentifier: StepIdentifier(),
      title: 'Time',
      text: 'Select the time of day when you take this medication',
      answerFormat: const MultipleChoiceAnswerFormat(textChoices: <TextChoice>[
        TextChoice(text: 'Morning', value: 'Morning'),
        TextChoice(text: 'Afternoon', value: 'Afternoon'),
        TextChoice(text: 'Evening', value: 'Evening'),
        TextChoice(text: 'Bedtime', value: 'Bedtime'),
        TextChoice(text: 'Other', value: 'Other'),
      ]),
    );

    var infoStep = QuestionStep(
      stepIdentifier: StepIdentifier(),
      title: 'Additional Information',
      answerFormat: const TextAnswerFormat(
          hint: 'Enter any additional information or dosage instructions'),
    );

    var conclusionStep = CompletionStep(
      stepIdentifier: StepIdentifier(),
      title: 'All done!',
      text: 'Your prescription is ready to be updated',
      buttonText: 'Complete Entry',
    );

    var steps = [nameStep, doseStep, timeStep, infoStep, conclusionStep];

    var task = OrderedTask(id: TaskIdentifier(), steps: steps);

    return Future.value(task);
  }

  List<dynamic> extractResults(Map<String, dynamic> data) {
    List<dynamic> results = [];

    data.forEach((key, value) {
      //print("$key - $value");
      if (key == "result") {
        if (value is List) {
          // Handle multiple options for "result"
          results.addAll(value.map((v) => v['value']));
        } else {
          results.add(value);
        }
      } else if (value is Map<String, dynamic>) {
        results.addAll(extractResults(value));
      } else if (value is List) {
        for (var item in value) {
          if (item is Map<String, dynamic>) {
            results.addAll(extractResults(item));
          }
        }
      }
    });

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: FutureBuilder<Task>(
              future: _getTask(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  final task = snapshot.data!;
                  return SurveyKit(
                    onResult: (SurveyResult result) {
                      final jsonResult = result.toJson();

                      var usableResults = extractResults(jsonResult);
                      print(usableResults);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    task: task,
                    showProgress: true,
                    localizations: const {
                      'cancel': 'Cancel',
                      'next': 'Next',
                    },
                  );
                }
                return const MyHomePage(title: 'Demo Page');
              })),
        ),
      ),
    );
  }
}
