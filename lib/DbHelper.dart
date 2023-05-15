import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'UserModel.dart';

class DbHelper {
  static Database? _db;

  static const String DB_Name = 'EmpData.db';
  static const String Table_User = 'registration';
  static const int Version = 1;

  static final cId = 'id';
  static const String C_FirstName = 'firstName';
  static const String C_LstName = 'lastName';
  static const String C_Email = 'regEmail';
  static const String C_BusinessName = 'businessName';
  static const String C_BusinessType = 'businessType';
  static const String C_DateController = 'dateController';
  static const String C_address = 'address';
  static const String C_State = 'State';
  static const String C_Country = 'Country';
  static const String C_City = 'City';
  static const String C_LandlineNo = 'LandlineNo';
  static const String C_MobileNo = 'MobileNo';
  static const String C_Password = 'password';

  Future<Database> get db async {
    return _db = await initDb();
  }

  initDb() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, DB_Name);
    print("path:::${path}");
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  // _onCreate(Database db, int intVersion) async {
  //   await db.execute("CREATE TABLE $Table_User ("
  //       " $cId INTEGER PRIMARY KEY,"
  //       " $C_FirstName TEXT, "
  //       " $C_LstName TEXT, "
  //       " $C_Email TEXT,"
  //       " $C_Password TEXT, "
  //       ")");
  // }
  Future _onCreate(Database db, int version)async{
    await db.execute(
        '''
       CREATE TABLE $Table_User(
            $cId INTEGER PRIMARY KEY,
            $C_FirstName TEXT NOT NULL,
            $C_LstName TEXT NOT NULL,
            $C_Email TEXT NOT NULL,
            $C_BusinessName TEXT NULL,
            $C_BusinessType TEXT NOT NULL,
            $C_DateController TEXT NOT NULL,
            $C_address TEXT NOT NULL,
            $C_Country TEXT NOT NULL,
            $C_State TEXT NOT NULL,
            $C_City TEXT NOT NULL,
            $C_LandlineNo TEXT NOT NULL,
            $C_MobileNo TEXT NOT NULL,
            $C_Password TEXT NOT NULL
            )
      '''
    );

  }

  // Future<int> saveData(UserModel user) async {
  //   var dbClient = await db;
  //   var res = await dbClient.insert(Table_User, user.toMap());
  //   return res;
  // }
  Future<int> insert(Map<String, dynamic> row) async{
    print("row1::");
    Database db = await this.db;
    print("row:::::${row}");
    return await db.insert(Table_User, row);
  }
  Future<List<Map<String, dynamic>>> query() async{
    Database db = await this.db;
    return await db.query(Table_User);
  }
  Future<int> deleteAllRecords() async {
    var dbClient = await db;
    return await dbClient.delete(Table_User);
  }

  Future<bool> getLoginUser(String emailId, String password) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $Table_User WHERE "
        "$C_Email = '$emailId' AND "
        "$C_Password = '$password'");
    print("res::${result}");
   // int? exists = Sqflite.firstIntValue(result);
    if(result.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  Future<int> updateUser(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.update(Table_User, user.toMap(),
        where: '$C_FirstName = ?', whereArgs: [user.firstName]);
    return res;
  }

  Future<int> deleteUser(String user_id) async {
    var dbClient = await db;
    var res = await dbClient
        .delete(Table_User, where: '$C_FirstName = ?', whereArgs: [user_id]);
    return res;
  }
}
