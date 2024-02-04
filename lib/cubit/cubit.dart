import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp/cubit/states.dart';
import 'package:mytodoapp/models/archived.dart';
import 'package:mytodoapp/models/done_tasks.dart';
import 'package:sqflite/sqflite.dart';

import '../models/new_tasks.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit():super(AppIntialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  int currindex=0;
  bool isBottomSheet=false;
  List <Map>newtasks=[];
  List <Map>doneTasks=[];
  List <Map>archivedTasks=[];
  Database? database;
  IconData fabIcon=Icons.edit;
  List <Widget>screens=[
    NewTasks(),
    DoneTasks(),
    ArchivedTasks()
  ];
  List<String>title=[
    'NewTasks',
    'EditTasks',
    'DoneTasks'
  ];
  void changeNav(int index){
    currindex=index;
    emit(AppChangeNavState());
  }
  void createDatabase(){
   openDatabase('mariam11.db',version: 1,
        onCreate:(database,version){
          print('Database is created');
          database.execute(
              'CREATE TABLE task (id INTEGER PRIMARY KEY, title TEXT, desc TEXT, cat TEXT,time TEXT, date TEXT, status TEXT)'
          ).then((value)  {

            print("creating table");
          }).catchError((error){
            print("error when creating table ${error.toString()}");
          });
        },onOpen: (database){
          getDataFromDatbase(database);
          print('Database is opened');
        } ).then((value) {
          database=value;
          emit(AppCreateDatabaseState());
    });

  }
 insertToDatabase({
    required String title,
    required String time,
    required String date,
    required String desc,
   required String cat,
  })async{
    await database!.transaction((txn) {
      return txn.rawInsert('INSERT INTO task(title, desc, cat,time, date, status) VALUES("$title","$desc","$cat","$time","$date", "new")');

    }).then((value) {
   print("${value}Inserted Sucessfully");
      emit(AppInsertIntoDatabaseState());
      getDataFromDatbase(database);
      //يا رب فك اضيقة
    }).catchError((error){
      print("error when inserting record ${error.toString()}");

    });

  }
  void getDataFromDatbase(database){
    newtasks=[];
    doneTasks=[];
    archivedTasks=[];
    emit(AppGetDatabaseLoadingState());
     database!.rawQuery('SELECT * FROM task').then((value) {

       // newtasks=value;
       // print(newtasks);
       value.forEach((element) {
       if(element['status']=='new'){
         newtasks.add(element);
       }
       else if(element['status']=='archived') {
         archivedTasks.add(element);
       }
       //jjjj
       else{
         doneTasks.add(element);
       }
       });
       emit(AppGetDatabaseState());


     });

  }
  void editData({
    required String title,
    required String time,
    required String date,
    required String desc,
    required String cat,
})async{
   database!.rawUpdate(
        'UPDATE task SET title = ?, desc = ?, cat = ?, time = ?, status = ? WHERE date = ?',
        ['$title','$desc' ,"$cat",'$time','archived', '$date']).then((value){
          emit(AppEditDatabaseState());
   });
  }
  void deleteDate({

    required int id,
  })async{
   database!.rawDelete('DELETE FROM task WHERE id = ?', ['$id']).
   then((value) {
     getDataFromDatbase(database);
     emit(AppDeleteDatabaseState());
   });
  }
  void updateDate({
    required String status,
    required int id,
})async{
    return await database!.rawUpdate(
        'UPDATE task SET  status= ?  WHERE id = ?',
        ['updated $status', '$id']).then((value)
    {
      getDataFromDatbase(database);
emit(AppUpdateDatabaseState());
    });
  }
void changeBottomSheet({
    required bool isShow,
    required IconData iconData,
}){
isBottomSheet=isShow;
fabIcon=iconData;
emit(AppChangeBottomSheetState());
}
}