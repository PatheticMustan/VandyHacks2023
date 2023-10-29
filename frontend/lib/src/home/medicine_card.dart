import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rx_scan/src/home/app_state.dart';
import 'package:rx_scan/src/home/questionaire.dart';

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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      

        Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${details.name} - ${details.dose}",
                  style: TextStyle(fontSize: 24, color: Colors.grey[800]),
                ),
                Container(height: 10),
                  Row(
                  children: [
                    for(var e in details.time)...{
                    Icon(timeIcons[e]),
                    const SizedBox(width: 15),
                    },
                    
                  ]
                ),
                Container(height: 10),
              

                Text(
                  details.info,
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
                Row(children: [
                  const Spacer(),
                  TextButton.icon(
                    icon: const Icon(Icons.create_outlined),
                    label: const Text(''),
                    onPressed: () {
                     appState.remove(details);
                     Navigator.push(context, 
                     MaterialPageRoute(builder: (context) => const Questionaire()));
                       },
                  ),
                  TextButton.icon(
                      icon: const Icon(Icons.delete_rounded),
                      label: const Text(''),
                      onPressed: () {
                        appState.remove(details);
                      })
                ])
              ]),
        ),
        Container(height: 5),
      ]),
    );
  }
}
