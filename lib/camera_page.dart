import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_mrz_scanner/flutter_mrz_scanner.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool isParsed = false;
  MRZController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: MRZScanner(
        withOverlay: true,
        onControllerCreated: onControllerCreated,
      ),
    );
  }

  @override
  void dispose() {
    controller?.stopPreview();
    super.dispose();
  }

  void onControllerCreated(MRZController controller) {
    this.controller = controller;

    controller.onParsed = (result) async {
      if (isParsed) {
        return;
      }
      isParsed = true;

      await showDialog<void>(
          context: context,
          builder: (context) {
            controller.takePhoto().then((value) {
              showDialog(context: context, builder: (BuildContext context) { 
                return AlertDialog(
                  content: Image.memory(value as Uint8List),
                );
              });
            });
            return AlertDialog(
                content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Country: ${result.countryCode}'),
                Text('Given names: ${result.givenNames}'),
                Text('Document number: ${result.documentNumber}'),
                Text('Nationality code: ${result.nationalityCountryCode}'),
                Text('Birthdate: ${result.birthDate}'),
                Text('Sex: ${result.sex.name}'),
                Text('Expriy date: ${result.expiryDate}'),
                ElevatedButton(
                  child: const Text('ok'),
                  onPressed: () {
                    isParsed = false;
                    return Navigator.pop(context, true);
                  },
                ),
              ],
            ));
          });
    };
    controller.onError = (error) => print(error);

    controller.startPreview();
  }
}
