import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:streams_ex/models/passport_datamodel.dart';

part 'database_state.dart';

class DatabaseCubit extends Cubit<DatabaseState> {
  DatabaseCubit() : super(DatabaseInitial());
  SharedPreferences? _prefs;
  List<PassPortModel> passports = [];
  PassPortModel? item;
  Database? db;

  Future<void> initializeDatabase() async {
    try {
      //print('##################[entered oncreate]#####################');
      emit(onInitializeDatabase());
      _prefs = await SharedPreferences.getInstance();

      String databasePath = await getDatabasesPath();
      String path = join(databasePath, 'local.db');
      Database? myDb;

      if (_prefs?.getBool('created') == null ||
          _prefs?.getBool('created') == false) {

        myDb = await openDatabase(path, version:1, onCreate: _onCreate);
        _prefs?.setBool('created', true);
      } else {
        myDb = await openDatabase(path);
      }
      db = myDb;
      print(_prefs?.getBool('created'));
      emit(onDatabaseSuccess());
    }catch(e){
      emit(onDatabaseFail(error: e.toString()));
    }
  }


  _onCreate(Database db,int v) async {
    try{
      emit(oncreateLoading());
      print('##################[entered oncreate]#####################');
      await db.execute('''
    CREATE TABLE "passports" (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
       "name" TEXT NOT NULL,
       "documentNo" TEXT,
       "countryCode" Text, 
       "sex" TEXT,
       "birth" TEXT,
       "expire" TEXT,
       "image" TEXT
    )
    ''');
      emit(oncreateSuccess());
    }catch(e){
      emit(oncreateFail(error: e.toString()));
    }
  }

  readData(String query) async {
    passports = [];
    emit(onGettingDataLoading());
    Database? Mydb = db;
    try{
      List<Map> response = await  Mydb!.rawQuery(query);
      for(var r in response){
        passports.add(
            PassPortModel(
                name: r['name'],
                countryCode: r['countryCode'],
                image: r['image'],
                birth: r['birth'],
                expire: r['expire'],
                sex: r['sex'],
                documentNo: r['documentNo'])
        );

      }
      emit(onGettingDataSuccess());
      return response;
    }catch(e){
      emit(onGettingDataFail(error: e.toString()));
    }



  }

  insertData(String query) async {
    emit(onInsertingDataLoading());
    Database? Mydb = db;
    try{
      int response =await  Mydb!.rawInsert(query);
      emit(onInsertingDataSuccess());
      return response;
    }catch(e){
      emit(onInsertingDataFail(error: e.toString()));
    }
  }



}
