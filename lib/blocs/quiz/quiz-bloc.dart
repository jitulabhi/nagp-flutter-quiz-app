import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/blocs/quiz/quiz-event.dart';
import 'package:quizapp/blocs/quiz/quiz-state.dart';

import '../../resources/repository.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final repository = Repository();
  StreamSubscription? _quizSubscription;
  QuizBloc() : super(QuizLoading());

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event is LoadQuiz) {
      yield* _mapLoadQuizToState();
    }
    if (event is UpdateQuiz) {
      yield* _mapUpdateQuizToState(event);
    }
    if(event is SelectQuiz){
      yield* _mapSelectedQuizToState(event);
    }
  }

  Stream<QuizState> _mapLoadQuizToState() async*{
    _quizSubscription?.cancel();
    repository.getQuizList().listen((quizList) => add(UpdateQuiz(quizList)));
  }

 Stream<QuizState> _mapUpdateQuizToState(UpdateQuiz event) async*{
   yield QuizLoaded(loadedList: event.quizList);

 }

Stream<QuizState> _mapSelectedQuizToState(SelectQuiz event) async*{
   yield QuizSelected(selectedQuiz: event.selected);
  }
}
