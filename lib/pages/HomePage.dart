// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quizapp/pages/ProfilePage.dart';
import 'package:quizapp/pages/QuizListPage.dart';
import 'package:quizapp/pages/ResultPage.dart';
import 'package:quizapp/resources/load-repository.dart';

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);

  final loadRepository = LoadRepository();

  @override
  Widget build(BuildContext context) {
   // loadRepository.loadData();
    
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Quiz App'),
          ),
          bottomNavigationBar: Container(
              color: Colors.blue,
              child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                 // indicatorSize: TabBarIndicatorSize.tab,
                 // indicatorPadding: EdgeInsets.all(5.0),
                  indicatorColor: Colors.blue,
                  // ignore: prefer_const_literals_to_create_immutables
                  tabs: [
                    Tab(text: 'Profile', icon: Icon(Icons.person)),
                    Tab(text: 'Quiz', icon: Icon(Icons.quiz)),
                    Tab(text: 'Result', icon: Icon(Icons.auto_graph)),
                  ])),
          body: TabBarView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [ProfilePage(), QuizListPage(), ResultPage()],
          ),
        ),
      ),
    );
  }

}
