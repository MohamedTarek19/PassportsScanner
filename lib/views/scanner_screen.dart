import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrz_scanner/mrz_scanner.dart';
import 'package:screenshot/screenshot.dart';
import 'package:streams_ex/app_cubits/mrz_cubit.dart';
import 'package:streams_ex/views/captured_data.dart';

class ScannerScreen extends StatelessWidget {
  final MRZController controller = MRZController();
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MrzCubit, MrzState>(
      builder: (context, state) {
        return Scaffold(
          body: Screenshot(
            controller: screenshotController,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                context
                    .read<MrzCubit>()
                    .ShowScanner(controller, screenshotController),
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                  ),
                  child: (state is onMrzWaiting || context.read<MrzCubit>().flag == false)
                  ? Center(
                    child: const CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                  )
                  : IconButton(
                      iconSize: 50,
                      onPressed: () {
                        controller.currentState?.resetScanning();
                        Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) {
                          return const CapturedData();
                        }));
                      },
                      icon: const Center(child: Icon(Icons.camera)),
                    ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/*

Text('Name : ${mrzResult.givenNames}'),
                              Text('Gender : ${mrzResult.sex.name}'),
                              Text('CountryCode : ${mrzResult.countryCode}'),
                              Text('Date of Birth : ${mrzResult.birthDate}'),
                              Text('Expiry Date : ${mrzResult.expiryDate}'),
                              Text('DocNum : ${mrzResult.documentNumber}'),
* */
