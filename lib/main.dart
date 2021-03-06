import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/blocs/quiz/quiz-bloc.dart';
import 'package:quizapp/blocs/quiz/quiz-event.dart';
import 'package:quizapp/pages/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
  return 
  MaterialApp(
    title: 'My Quiz App',
  home: HomePage()
  );

  
  }
}
  

