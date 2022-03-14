import 'package:quizapp/models/question_option_model.dart';

class QuestionModel {
  late String _label;
  late QuestionOptionModel _optionA;
  late QuestionOptionModel _optionB;
  late QuestionOptionModel _optionC;
  late QuestionOptionModel _optionD;

  String get label => _label;
  QuestionOptionModel get optionA => _optionA;
  QuestionOptionModel get optionB => _optionB;
  QuestionOptionModel get optionC => _optionC;
  QuestionOptionModel get optionD => _optionD;

  QuestionModel(String label, QuestionOptionModel optionA, QuestionOptionModel optionB, QuestionOptionModel optionC,
      QuestionOptionModel optionD) {
    _label = label;
    _optionA = optionA;
    _optionB = optionB;
    _optionC = optionC;
    _optionD = optionD;
  }
}