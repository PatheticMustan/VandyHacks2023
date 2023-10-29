import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:provider/provider.dart';
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
      text: 'Your prescription is ready to be uploaded',
      buttonText: 'Send to Google Calendar',
    );

    var steps = [nameStep, doseStep, timeStep, infoStep, conclusionStep];

    var task = NavigableTask(id: TaskIdentifier(), steps: steps);

    return Future.value(task);
  }

  List<dynamic> extractResults(Map<String, dynamic> data) {
  List<dynamic> results = [];

 
  data.forEach((key, value) {
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
                      var jsonResult = result.toJson();
                      print(jsonResult);

                      var theStuff = extractResults(jsonResult);
                      print(theStuff);

                      List<String> timeList = [];

                      for (var i = 2; i < theStuff.length - 1; i++) {
                        timeList.add(theStuff[i]);
                      }

                      var currentDetails =  
                      PrescriptionDetails(theStuff[0], theStuff[1], timeList, theStuff[theStuff.length - 1]);

                      
                    },
                    task: task,
                    showProgress: true,
                    localizations: const {
                      'cancel': 'Cancel',
                      'next': 'Next',
                    },
                  );
                }
                return const CircularProgressIndicator.adaptive();
              })),
        ),
      ),
    );
  }
}
