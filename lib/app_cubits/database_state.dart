part of 'database_cubit.dart';

@immutable
abstract class DatabaseState {}

class DatabaseInitial extends DatabaseState {}
class onInitializeDatabase extends DatabaseState {}
class onDatabaseSuccess extends DatabaseState {}
class onDatabaseFail extends DatabaseState {
  onDatabaseFail({required this.error});
  String error;
}

class oncreateLoading extends DatabaseState {}
class oncreateSuccess extends DatabaseState {}
class oncreateFail extends DatabaseState {
  oncreateFail({required this.error});
  String error;
}

class onGettingDataLoading extends DatabaseState {}
class onGettingDataSuccess extends DatabaseState {}
class onGettingDataFail extends DatabaseState {
  onGettingDataFail({required this.error});
  String error;
}

class onInsertingDataLoading extends DatabaseState {}
class onInsertingDataSuccess extends DatabaseState {}
class onInsertingDataFail extends DatabaseState {
  onInsertingDataFail({required this.error});
  String error;
}



