import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/models/answers_model.dart';

import '../../resources/repository.dart';
import 'result-event.dart';
import 'result-state.dart';
import 'dart:async';
import "package:collection/collection.dart";

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final repository = Repository();
  StreamSubscription? _resultSubscription;
  ResultBloc() : super(ResultLoading(list: List<AnswerModel>.from([])));

  @override
  Stream<ResultState> mapEventToState(ResultEvent event) async* {
    if (event is LoadResult) {
      yield* _mapLoadResultToState(event);
    }
    if (event is UpdateResult) {
      yield* _mapUpdateResultToState(event);
    }
  }

  Stream<ResultState> _mapLoadResultToState(LoadResult event) async* {
    _resultSubscription?.cancel();
    yield ResultLoading(list: List<AnswerModel>.from([]));
    repository
        .getAnswerList("profile-1")
        .listen((answerList) => add(UpdateResult(answerList)));
  }

  Stream<ResultState> _mapUpdateResultToState(UpdateResult event) async* {
    yield ResultLoaded(list: event.list);
    print(event.list);
    if (event.list.isNotEmpty) {
      Map<String, Map<int, int>> mapByQuizAndQuizId = {};
      Map<String, List<AnswerModel>> groupByQuizName =
          event.list.groupListsBy((element) => element.quizModel.label);
      groupByQuizName.keys.forEach((quizName) {
        List<AnswerModel> byQuizName =
            groupByQuizName[quizName]!.toList(growable: false);
        Map<int, List<AnswerModel>> groupByQuizId =
            byQuizName.groupListsBy((element) => element.quizId);
        Map<int, int> finalMapByQuizId = {};
        groupByQuizId.keys.forEach((quizId) {
          int marks = groupByQuizId[quizId]!
              .toList(growable: false)
              .map((e) => e.optionSelected.marks)
              .sum;
          finalMapByQuizId.putIfAbsent(quizId, () => marks);
        });
        mapByQuizAndQuizId.putIfAbsent(quizName, () => finalMapByQuizId);
      });
      print(mapByQuizAndQuizId);
    }
  }
}
