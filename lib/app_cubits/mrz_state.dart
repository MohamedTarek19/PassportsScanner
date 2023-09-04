part of 'mrz_cubit.dart';

@immutable
abstract class MrzState {}

class MrzInitial extends MrzState {}

class onMrzSuccess extends MrzState {}
class onMrzWaiting extends MrzState {}
class onMrzFailure extends MrzState {
  onMrzFailure({required this.error});
  String error;

}

class onScreenshotFailure extends MrzState {
  onScreenshotFailure({required this.error});
  String error;

}
