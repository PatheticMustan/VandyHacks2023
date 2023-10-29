import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rx_scan/src/home/questionaire.dart';

class MyAppState extends ChangeNotifier {
  var presList = [];

  void add() {
    presList.add(PrescriptionCard(
        details: const PrescriptionDetails('MEDICATION_NAME', 'MEDICATION_DOSE',
            ['Morning', 'Afternoon'], 'ADDITIONAL_INFO')));
    notifyListeners();
  }

  void remove() {
    presList.remove(presList.last);
    notifyListeners();
  }
}

class PrescriptionDetails {
  final String name;
  final String dose;
  final List<String> time;
  final String info;

  const PrescriptionDetails(this.name, this.dose, this.time, this.info);
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
    var appState = context.watch<MyAppState>();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
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
                  'Take in ${details.time}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
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
  }
}
