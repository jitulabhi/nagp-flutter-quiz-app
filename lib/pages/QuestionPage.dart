import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/blocs/question/question-event.dart';
import 'package:quizapp/models/quiz-model.dart';
import 'package:quizapp/pages/QuizListPage.dart';

import '../blocs/question/question-bloc.dart';
import '../blocs/question/question-state.dart';
import 'BuildQuestion.dart';

class QuestionPage extends StatelessWidget {
  final QuizModel selectedQuiz;
  final int quizId = new DateTime.now().millisecondsSinceEpoch;
  final int totalQuizTime = 1;
  Timer? timer;

  QuestionPage(this.selectedQuiz);

  startTimer(BuildContext context) {
    if (timer == null || !timer!.isActive) print("Tiems start");
    timer = Timer(Duration(minutes: totalQuizTime), () {
      print("Times up");
      BlocProvider.of<QuestionBloc>(context).add(FinishQuestion(this.quizId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => QuestionBloc()..add(LoadQuestion(selectedQuiz)),
        child: Scaffold(body:
            BlocBuilder<QuestionBloc, QuestionState>(builder: (context, state) {
          if (state is QuestionLoading) {
            startTimer(context);
            return const Center(child: CircularProgressIndicator());
          }
          if (state is QuestionLoaded ||
              state is QuestionOptionSelect ||
              state is QuestionSkip) {
            return BuildQuestion(quizId);
          }
          if (state is QuestionFinish) {
            timer?.cancel();
            return QuizListPage();
          } else {
            return Text('Something went wrong');
          }
        }
        )
       
        )
        );
  }
}


