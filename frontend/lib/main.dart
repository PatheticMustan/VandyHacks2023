import 'package:flutter/material.dart';

import'dart:convert';
import 'package:survey_kit/survey_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  final List<String> results;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('pill id'),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Placeholder();
                  }));
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take picture'),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SurveyKit(
                      onResult: (SurveyResult result) {
                        final jsonResult = result.toJson();
                        jsonDecode(jsonResult);
                      },
                      task: manualSurvey(),
                      showProgress: true,
                      localizations: const {
                        'cancel': 'Cancel',
                        'next': 'Next',
                      },
                    );
                  }));
                },
                icon: const Icon(Icons.add),
                label: const Text('Add manually'),
              ),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }


   //Data: medication name, dosage, time of day and frequency, important info

    Task manualSurvey() {

      var task = NavigableTask(
        id: TaskIdentifier(),
        steps: [
      QuestionStep(
        title: 'Medication Survey',
        text: 'What is the name of the medication you are taking?',
        answerFormat: const TextAnswerFormat(maxLines: 1),
      ),

      QuestionStep(
        title: 'Medication Survey',
        text: 'What is the dosage of this medication?',
        answerFormat: const TextAnswerFormat(maxLines: 1),
      ),

      QuestionStep(
          title: 'Medication Survey',
          text: 'When do you take [][][][]',
          answerFormat: const MultipleChoiceAnswerFormat(textChoices: [
            TextChoice(text: 'Morning', value: 'Morning'),
            TextChoice(text: 'Midday', value: 'Midday'),
            TextChoice(text: 'Evening', value: 'Evening'),
            TextChoice(text: 'Bedtime', value: 'Bedtime'),
            TextChoice(text: 'Other', value: 'Other'),
          ])),

      

      QuestionStep(
        title: 'Medication Survey',
        text: 'How much of this medication do you take in the ',
        answerFormat: const TextAnswerFormat(maxLines: 1),
      ),

      QuestionStep(
        title: 'Medication Survey',
        text: 'Any other important information you\'d like to add?',
        answerFormat: const BooleanAnswerFormat(positiveAnswer: 'Yes', negativeAnswer: 'No'),
      ),

      QuestionStep(
        title: 'Medication Survey',
        text: 'Please list any important directions below:',
        answerFormat: const TextAnswerFormat(),
      ),


      CompletionStep(
        stepIdentifier: StepIdentifier(id: 'what'),
        title: 'Thank you!',
        text: 'Your information has been saved',
        buttonText: 'Upload to Google Calendar',
      ),
        ]
    );
    
    task.addNavigationRule(
      forTriggerStepIdentifier: task.steps[4].stepIdentifier,
      navigationRule: ConditionalNavigationRule(
        resultToStepIdentifierMapper: (input) {
          switch (input) {
            case 'Yes':
              return task.steps[5].stepIdentifier;
            case 'No':
              return task.steps[6].stepIdentifier;
            default:
              return null;
          }
        }
     )
    );

   /*  task.addNavigationRule(
       forTriggerStepIdentifier: task.steps[2].stepIdentifier,
       navigationRule: 
    )
    */ 
    return task;
    
    }


    String jsonDecode(Map<String, dynamic> theJson) {
      Map<String, dynamic> data = json.decode(theJson);

      print(data);

      return data;
    }
}



