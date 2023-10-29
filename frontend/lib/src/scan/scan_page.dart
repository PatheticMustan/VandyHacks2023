import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:http/http.dart' as http;
import 'package:rx_scan/main.dart';
import 'package:rx_scan/src/home/app_state.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String? _imagePath;
  late MyAppState appState;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getImageFromCamera(BuildContext context) async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      // alert them the permission is disabled
      if (context.mounted) {
        Alert(
                context: context,
                title: "Permissions",
                desc: "The Camera permission is required to take a picture")
            .show();
      }
      return;
    }

    // Generate filepath for saving
    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    bool success = false;
    try {
      success = await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true,
        androidScanTitle: 'Scan Your Prescription',
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
      print("success: $success");
    } catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (success) {
        _imagePath = imagePath;
        uploadImage(imagePath);
      }
    });
  }

  Future<void> getImageFromGallery() async {
    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    bool success = false;
    try {
      success = await EdgeDetection.detectEdgeFromGallery(
        imagePath,
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
      print("success: $success");
    } catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (success) {
        _imagePath = imagePath;
        uploadImage(imagePath);
      }
    });
  }

  void uploadImage(String imagePath) async {
    String uploadURL = "http://35.222.254.60:5000/upload";

    File imageFile = File(imagePath);
    Stream<List<int>> stream = http.ByteStream(imageFile.openRead());
    stream.cast();
    int length = await imageFile.length();

    Uri uri = Uri.parse(uploadURL);

    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final List parsed = json.decode(response.body);
      // [dose_times, name, dosage, info]
      List<bool> d = List<bool>.from(parsed[0] as List);
      List<String> times = d.map((v) => v.toString()).toList();

      String name = parsed[1];
      String dosage = parsed[2];
      String info = parsed[3];

      // pretty print results
      appState.add(PrescriptionDetails(name, dosage, times, info));
    } else {
      print("error when processing prescription, ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    appState = context.watch<MyAppState>();
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title:
                  const Text('Scanner', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blueAccent,
            ),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: ElevatedButton(
                          onPressed: () {
                            getImageFromCamera(context);
                          },
                          child: const Text('Scan'))),
                  const SizedBox(height: 20),
                  Center(
                      child: ElevatedButton(
                          onPressed: getImageFromGallery,
                          child: const Text('Upload'))),
                  const SizedBox(height: 20),
                  const Text('Cropped image path:'),
                  Padding(
                      padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                      child: Text(_imagePath.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14))),
                  Visibility(
                      visible: (_imagePath != null),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(File(_imagePath ?? ''))))
                ])));
  }
}
