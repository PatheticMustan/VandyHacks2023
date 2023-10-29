import 'package:flutter/widgets.dart';

import 'medicine_card.dart';

class MyAppState extends ChangeNotifier {
  var presList = [];

  void add(PrescriptionDetails details) {
    presList.add(PrescriptionCard(
        details: PrescriptionDetails(
            details.name, details.dose, details.time, details.info)));
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