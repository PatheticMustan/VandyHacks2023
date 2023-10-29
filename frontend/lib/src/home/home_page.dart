import 'dart:js_util';

import 'package:flutter/material.dart';
import 'questionaire.dart';
import 'package:rx_scan/main.dart';
import 'package:rx_scan/globals.dart' as globals;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class MyAppState extends ChangeNotifier {
  var presList = [];

  void add() {
    presList.add(PrescriptionCard(details:  PrescriptionDetails('MEDICATION_NAME', 'MEDICATION_DOSE', ['Morning', 'Afternoon'], 'ADDITIONAL_INFO')));
    notifyListeners();
  }

  void remove() {
    presList.remove(presList.last);
    notifyListeners();
  }
}


class _HomePageState extends State<HomePage> {


  

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Builder(builder: (context) {
      return Scaffold(
        body: Center(
            child: Column(
          children: [
            for (PrescriptionCard p in appState.presList) p,
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            appState.add();
          },
          tooltip: 'New',
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}

class PrescriptionDetails {
  const PrescriptionDetails(this.name, this.dose, this.time, this.info);
  final String name;
  final String dose;
  final List<String> time;
  final String info;
}

class PrescriptionCard extends StatelessWidget {
  PrescriptionCard({super.key, required this.details});

  final PrescriptionDetails details;

  final timeIcons = <String, IconData>{
    'Morning': Icons.sunny_snowing,
    'Afternoon': Icons.sunny,
    'Evening': Icons.bedtime_rounded,
    'Bedtime': Icons.airline_seat_individual_suite_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var appState = context.watch<MyAppState>();

    return Builder(builder: (context) {
      return Card(
        // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        // Set the clip behavior of the card
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // Define the child widgets of the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
       
            // Add a container with padding that contains the card's title, text, and buttons
            Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Display the card's title using a font size of 24 and a dark grey color
                  Text(
                    '${details.name} - ${details.dose}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[800],
                    ),
                  ),
                  // Add a space between the title and the text
                  Container(height: 10),
                  // Display the card's text using a font size of 15 and a light grey color
                  Text(
                    details.info,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  // Add a row with two buttons spaced apart and aligned to the right side of the card
                  Row(
                    children: <Widget>[
                      // Add a spacer to push the buttons to the right side of the card
                      const Spacer(),
                      // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                      TextButton.icon(
                        icon: const Icon(Icons.create_outlined),
                        label: const Text(''),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Questionaire()));
                          //edit an already existing card
                        },
                      ),
                      // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
                      TextButton.icon(
                        icon: const Icon(
                          Icons.delete_rounded,
                        ),
                        label: const Text(''),
                        onPressed: () {
                          appState.remove();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Add a small space between the card and the next widget
            Container(height: 5),
          ],
        ),
      );
    });
  }
}


