import 'package:quizapp/blocs/question/question-state.dart';

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/models/answers_model.dart';
import 'package:quizapp/models/question_model.dart';
import 'package:quizapp/models/quiz-model.dart';

import '../../resources/repository.dart';
import 'question-event.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final repository = Repository();
  StreamSubscription? _questionSubscription;
  QuestionBloc()
      : super(QuestionLoading(
            list: List<QuestionModel>.from([]),
            currentIndex: 0,
            selectedQuiz: QuizModel("", "")));

  @override
  Stream<QuestionState> mapEventToState(QuestionEvent event) async* {
    if (event is LoadQuestion) {
      yield* _mapLoadQuestionToState(event);
    }
    if (event is UpdateQuestion) {
      yield* _mapUpdateQuestionToState(event);
    }
    if (event is SelectQuestionOption) {
      yield* _mapSelectedOptionToState(event);
    }
    if (event is FinishQuestion) {
      yield* _mapFinishQuestionToState(event);
    }
    if (event is SkipQuestion) {
      yield* _mapSkipQuestionToState(event);
    }
  }

  Stream<QuestionState> _mapLoadQuestionToState(LoadQuestion event) async* {
    _questionSubscription?.cancel();
    yield QuestionLoading(
        list: List<QuestionModel>.from([]),
        currentIndex: 0,
        selectedQuiz: event.selectedQuiz);
    repository
        .getQuestionList(event.selectedQuiz.id)
        .listen((questionList) => add(UpdateQuestion(questionList)));
  }

  Stream<QuestionState> _mapUpdateQuestionToState(UpdateQuestion event) async* {
    yield QuestionLoaded(
        list: event.questionList,
        currentIndex: 0,
        selectedQuiz: state.selectedQuiz);
  }

  Stream<QuestionState> _mapSelectedOptionToState(
      SelectQuestionOption event) async* {
    AnswerModel model = AnswerModel(
        "profile-1",
        event.quizId,
        state.selectedQuiz,
        state.list[state.currentIndex].label,
        event.selectedOption);
    repository.saveQuestionAnswer(model);
    int currentIndex = state.currentIndex;
    //if this is last question.
    if (currentIndex == state.list.length - 1) {
      yield QuestionFinish(
          list: state.list,
          currentIndex: state.currentIndex,
          selectedQuiz: state.selectedQuiz);
    } else {
      yield QuestionOptionSelect(
          list: state.list,
          currentIndex: ++state.currentIndex,
          selectedQuiz: state.selectedQuiz,
          selectedOption: event.selectedOption);
    }
  }

  Stream<QuestionState> _mapFinishQuestionToState(FinishQuestion event) async* {
    yield QuestionFinish(
        list: state.list,
        currentIndex: state.currentIndex,
        selectedQuiz: state.selectedQuiz);
  }

  Stream<QuestionState> _mapSkipQuestionToState(SkipQuestion event) async* {
    //if this is last
    if (state.currentIndex == state.list.length - 1) {
      yield QuestionFinish(
          list: state.list,
          currentIndex: state.currentIndex,
          selectedQuiz: state.selectedQuiz);
    } else {
      yield QuestionSkip(
          list: state.list,
          currentIndex: ++state.currentIndex,
          selectedQuiz: state.selectedQuiz);
    }
  }
}
