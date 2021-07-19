import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/archived_task/archived_task_screen.dart';
import 'package:todo_app/modules/done_task/done_task_screen.dart';
import 'package:todo_app/modules/new_task/new_task_screen.dart';
import '../state.dart';

class HomeCubit extends Cubit<AppState> {
  HomeCubit() : super(AppInitState());

  // CREATE OBJECT FROM APP CUBIT TO USE IT IN ALL APP
  static HomeCubit get(context) => BlocProvider.of(context);

  // Bottom Nav
  int currentIndex = 0;

  List<Widget> screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchivedTaskScreen()
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  void changeBottomNavIndex(index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  // Bottom Sheet
  bool isBottomSheet = false;
  IconData fatIcon = Icons.edit;

  void changeBottomSheetIcon({bool isShow, IconData icon}) {
    isBottomSheet = isShow;
    fatIcon = icon;
    emit(AppBottomSheetState());
  }

  // Data base
  Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void createDatabase() async {
    database = await openDatabase('Todo.db', version: 1,
        onCreate: (database, version) {
      print('create database');

      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT  , time TEXT ,  date TEXT, status TEXT)')
          .then((value) {
        print('database created');
        emit(AppCreateDatabaseState());
      }).catchError((error) {
        print('error when created database ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('database opened');
    });
  }

  Future insertToDatabase(
      {@required String title,
      @required String time,
      @required String date}) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title , time , date , status) VALUES("$title","$time","$date","new")')
          .then((value) {
        print('data inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('error when inserted database ${error.toString()}');
      });
      return null;
    });
  }

  void getDataFromDatabase(database) async {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData({String status, int id}) {
    database.rawUpdate(
      'UPDATE tasks SET status = ?  WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({int id}) {
    database.rawUpdate(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}
