import 'package:quizapp/models/question_option_model.dart';
import 'package:quizapp/models/quiz-model.dart';

class AnswerModel {
  late String _profileId;
  late String _quizId;
  late QuizModel _quiz;
  late String _questionLabel;
  late QuestionOptionModel _optionSelected;

  String get profileId => _profileId;
  String get quizId => _quizId;
  QuizModel get quizModel => _quiz;
  String get questionLabel => _questionLabel;
  QuestionOptionModel get optionSelected => _optionSelected;

  AnswerModel(String profileId, String quizId, QuizModel quizModel, String questionLabel, QuestionOptionModel optionSelected){
    _profileId = profileId;
    _quizId = quizId;
    _quiz = quizModel;
    _questionLabel = questionLabel;
    _optionSelected = optionSelected;
  }

  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
      'quizId': quizId,
      'quiz': quizModel.toJson(),
      'questionLabel': questionLabel,
      'optionSelected': optionSelected.toJson()
    };
  }

}