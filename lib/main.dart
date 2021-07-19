import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/layouts/home_layout.dart';
import 'package:todo_app/shared/bloc_observer.dart';


void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}

