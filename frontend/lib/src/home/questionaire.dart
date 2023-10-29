import 'package:flutter/material.dart';

import 'package:survey_kit/survey_kit.dart';

class Questionaire extends StatefulWidget {
  const Questionaire({super.key});

  @override
  State<Questionaire> createState() => _QuestionaireState();
}

class _QuestionaireState extends State<Questionaire> {
  
  Future<Task> _getTask() {
    var nameStep = QuestionStep(
        title: 'Medication',
        answerFormat:
            const TextAnswerFormat(hint: 'Enter the name of your medication'));

    var doseStep = QuestionStep(
      title: 'Dosage',
      answerFormat:
          const TextAnswerFormat(hint: 'Enter the dosage of your medication'),
    );

    var timeStep = QuestionStep(
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
                      print(result.toString());
                      Navigator.pushNamed(context, '/');
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
