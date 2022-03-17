import 'package:quizapp/models/answers_model.dart';

import '../../models/result_bar_chart_model.dart';

class ResultState{
  List<AnswerModel> list;
  Map<String, Map<int, ResultBarChartModel>> mapByQuizAndQuizId;


  ResultState(this.list, this.mapByQuizAndQuizId);


}

class ResultLoading extends ResultState {
  ResultLoading({list: List<AnswerModel> }) : super(list, {});

}

class ResultLoaded extends ResultState {
  ResultLoaded({list: List<AnswerModel>, mapByQuizAndQuizId: Map<String, Map<int, ResultBarChartModel>> }) : super(list, mapByQuizAndQuizId);

}