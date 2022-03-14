import 'package:quizapp/models/answers_model.dart';

class ResultState{
  List<AnswerModel> list;

  ResultState(this.list);


}

class ResultLoading extends ResultState {
  ResultLoading({list: List<AnswerModel>}) : super(list);

}

class ResultLoaded extends ResultState {
  ResultLoaded({list: List<AnswerModel> }) : super(list);

}