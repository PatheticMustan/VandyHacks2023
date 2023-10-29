import 'package:flutter/widgets.dart';

class MyAppState extends ChangeNotifier {
  List<PrescriptionDetails> presList = [];

  void add(PrescriptionDetails details) {
    presList.add(PrescriptionDetails(
        details.name, details.dose, details.time, details.info));
    notifyListeners();
  }

  void remove(PrescriptionDetails details) {
    presList.remove(details);
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
