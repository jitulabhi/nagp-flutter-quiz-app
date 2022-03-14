import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/blocs/question/question-event.dart';
import 'package:quizapp/models/quiz-model.dart';
import 'package:quizapp/pages/QuizListPage.dart';

import '../blocs/question/question-bloc.dart';
import '../blocs/question/question-state.dart';
import 'BuildQuestion.dart';

class QuestionPage extends StatelessWidget{
final QuizModel selectedQuiz;
final String quizId = generateRandomString(5);

QuestionPage(this.selectedQuiz);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => QuestionBloc()..add(LoadQuestion(selectedQuiz)),
    child:  Scaffold(
      body: 
          BlocBuilder<QuestionBloc, QuestionState>(builder: (context, state) {
            if (state is QuestionLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is QuestionLoaded || state is QuestionOptionSelect || state is QuestionSkip) {
              return BuildQuestion(quizId);
            } 
            if(state is QuestionFinish){
              return QuizListPage();
            }
            else {
              return Text('Something went wrong');
            }
          })
    ));
  }

}

String generateRandomString(int length) {
  final _random = Random();
  const _availableChars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final randomString = List.generate(length,
          (index) => _availableChars[_random.nextInt(_availableChars.length)])
      .join();

  return randomString;
}

