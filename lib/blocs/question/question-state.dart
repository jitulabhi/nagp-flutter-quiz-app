import 'package:quizapp/models/question_option_model.dart';

import '../../models/question_model.dart';
import '../../models/quiz-model.dart';

class QuestionState{
  late List<QuestionModel> list;
  late QuizModel selectedQuiz;
  int currentIndex = 0;

  QuestionState(this.list, this.currentIndex, this.selectedQuiz);
}

class QuestionLoading extends QuestionState {
  QuestionLoading({list:List<QuestionModel>, currentIndex: int, selectedQuiz:QuizModel  }): super(list, currentIndex, selectedQuiz);
}


class QuestionLoaded extends QuestionState {
  QuestionLoaded({list:List<QuestionModel>, currentIndex: int, selectedQuiz:QuizModel  }) :super(list, currentIndex, selectedQuiz){
  currentIndex = 0;
  }
   
}

class QuestionOptionSelect extends QuestionState {  

  late QuestionOptionModel selectedOption;

  QuestionOptionSelect({list:List<QuestionModel>, currentIndex: int, selectedQuiz:QuizModel, selectedOption:QuestionOptionModel   }) :super(list, currentIndex, selectedQuiz){
  currentIndex++;
  }
}

class QuestionFinish extends QuestionState {  

  QuestionFinish({list:List<QuestionModel>, currentIndex: int, selectedQuiz:QuizModel, selectedOption:QuestionOptionModel   }) :super(list, currentIndex, selectedQuiz);
  
}

class QuestionSkip extends QuestionState {  

  QuestionSkip({list:List<QuestionModel>, currentIndex: int, selectedQuiz:QuizModel  }) :super(list, currentIndex, selectedQuiz);
  
}
