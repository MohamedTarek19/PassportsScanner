import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mrz_scanner/mrz_scanner.dart';
import 'package:screenshot/screenshot.dart';

part 'mrz_state.dart';

class MrzCubit extends Cubit<MrzState> {
  MrzCubit() : super(MrzInitial());

  MRZResult? result;
  Uint8List? passportPhoto;
  bool flag = false;
  Widget ShowScanner(MRZController controller, ScreenshotController ssController)  {
    try{
      return MRZScanner(
        showOverlay: false,
        controller: controller,
        onSuccess: (mrzResult) async {
          emit(onMrzWaiting());
          ssController.capture().then((image) {
            result = mrzResult;
            passportPhoto = image;
            flag = true;
            emit(onMrzSuccess());
          }).catchError((onError) {
            emit(onScreenshotFailure(error: onError.toString()));
            print(onError);
          });
        },
      );
    }catch(e){
      emit(onMrzFailure(error: e.toString()));
      return Container();
    }

  }
}
