import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/blocs/quiz/quiz-event.dart';
import 'package:quizapp/models/quiz-model.dart';

import '../blocs/quiz/quiz-bloc.dart';
import '../blocs/quiz/quiz-state.dart';
import 'QuestionPage.dart';

class QuizListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => QuizBloc()..add(LoadQuiz()),
    child: Scaffold(
        body: 
          BlocBuilder<QuizBloc, QuizState>(builder: (context, state) {
            if (state is QuizLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is QuizLoaded) {
              return ListView.builder(
                  itemCount: state.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text(state.list[index].label), 
                    onTap: (){
                       context.read<QuizBloc>().add(SelectQuiz(state.list[index]));
                    }, leading: Icon(Icons.quiz),
                    subtitle: Text(state.list[index].description),
                    );
                  });
            } if(state is QuizSelected){
              return QuestionPage(state.selected);
            }else {
              return Text('Something wnet wrong');
            }
          })
        
    ));
  }
}
