import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'medicine_card.dart';

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
                appState.add();
              },
              tooltip: 'New',
              child: const Icon(Icons.add),
            ),
            body: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                for (PrescriptionCard p in appState.presList) p,
              ],
            )));
  }
}
