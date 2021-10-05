import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_moor/data/moor_database.dart';
import 'package:todo_list_moor/ui/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
     create: (BuildContext context) { 
       // ignore: prefer_const_constructors
       AppDatabase();
      },
       // ignore: prefer_const_constructors
       child :MaterialApp(
         // ignore: prefer_const_constructors
         home: HomePage(
           title: 'Material App',
         ),
       )
      
    );
  }
}

