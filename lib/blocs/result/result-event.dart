import 'package:quizapp/models/answers_model.dart';

class ResultEvent {

}

class LoadResult extends ResultEvent {

}

class UpdateResult extends ResultEvent {
  List<AnswerModel> list;
  UpdateResult(this.list);
}