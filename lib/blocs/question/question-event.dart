import 'package:quizapp/models/question_model.dart';
import 'package:quizapp/models/question_option_model.dart';
import 'package:quizapp/models/quiz-model.dart';

class QuestionEvent {

}

class LoadQuestion extends QuestionEvent{
   QuizModel selectedQuiz;
  LoadQuestion(this.selectedQuiz);

}

class UpdateQuestion extends QuestionEvent {
  List<QuestionModel> questionList = [];
  UpdateQuestion(this.questionList);

}

class SelectQuestionOption extends QuestionEvent {
  int quizId;
   QuestionOptionModel selectedOption;
   SelectQuestionOption(this.quizId, this.selectedOption);

}

class FinishQuestion extends QuestionEvent {
  FinishQuestion();
}

class SkipQuestion extends QuestionEvent {
  SkipQuestion();
}