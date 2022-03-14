import 'package:quizapp/models/quiz-model.dart';

 abstract class QuizState{ 
  late QuizModel selected;
   List<QuizModel> list = [];
  QuizState(); 
   

}

class QuizLoading extends QuizState {
   
  
}

class QuizLoaded extends QuizState{
 QuizLoaded({loadedList : List<QuizModel>}){
   list.addAll(loadedList);
 }
}

class QuizSelected extends QuizState {
  QuizSelected({state: QuizState, selectedQuiz : QuizModel}){
    selected = selectedQuiz;
  }
}






