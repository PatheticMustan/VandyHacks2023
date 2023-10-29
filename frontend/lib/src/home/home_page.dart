import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rx_scan/src/home/app_state.dart';
import 'medicine_card.dart';
import 'questionaire.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Medicine View',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blueAccent,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
      MaterialPageRoute(builder: (context) => const Questionaire()));
              },
              tooltip: 'New',
              child: const Icon(Icons.add),
            ),
            body: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                for (PrescriptionDetails p in appState.presList)
                  PrescriptionCard(
                    details: p,
                  ),
              ],
            )));
  }
}
