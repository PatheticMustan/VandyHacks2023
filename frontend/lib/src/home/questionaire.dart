import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:survey_kit/survey_kit.dart';

class Questionaire extends StatelessWidget {
  Questionaire({super.key, });

 var nameStep = QuestionStep(
  title: 'Medication',
  answerFormat: const TextAnswerFormat(hint: 'Enter the name of your medication'));
 

 var doseStep = QuestionStep(
  title: 'Dosage',
  answerFormat: const TextAnswerFormat(hint: 'Enter the dosage of your medication'),
 );
 
 var timeStep = QuestionStep(
  title: 'Time',
  text: 'Select the time of day when you take this medication',
  answerFormat: const MultipleChoiceAnswerFormat(
    textChoices:  <TextChoice>[
       TextChoice(text: 'Morning', value: 'Morning'), 
       TextChoice(text: 'Afternoon', value: 'Afternoon'), 
       TextChoice(text: 'Evening', value: 'Evening'), 
       TextChoice(text: 'Bedtime', value: 'Bedtime'),
       TextChoice(text: 'Other', value: 'Other'), ]
  ),
 );

 var infoStep = QuestionStep(
  title: 'Additional Information',
  answerFormat: const TextAnswerFormat(hint: 'Enter any additional information or dosage instructions'),
 );

late var steps = [nameStep, doseStep, timeStep, infoStep];

late Task task = NavigableTask(steps: steps);


@override
Widget build(BuildContext context) {

    return Scaffold(
      body: SurveyKit(
        onResult: (SurveyResult result) {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => HomePage()),);},
      
        task: task,
      ),
   

    );
  }
}

