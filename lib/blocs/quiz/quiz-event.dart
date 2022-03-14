import 'package:quizapp/models/quiz-model.dart';

class QuizEvent {

}

class LoadQuiz extends QuizEvent {}

class UpdateQuiz extends QuizEvent {
  final List<QuizModel> quizList;
  UpdateQuiz(this.quizList);
}

class SelectQuiz extends QuizEvent {
  final QuizModel selected;
  SelectQuiz(this.selected);
}