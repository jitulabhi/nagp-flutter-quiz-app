import 'package:cloud_firestore/cloud_firestore.dart';

class LoadRepository {
  loadData() {
    loadQuizList();
    loadQuestionList();
  }

  loadQuizList()  {
    
      FirebaseFirestore.instance.collection('quiz-list').add(
          {'id': '1', 'label': 'Java', 'description': 'This is java test'});
      FirebaseFirestore.instance.collection('quiz-list').add(
          {'id': '2', 'label': '.Net', 'description': 'This is java test'});
      FirebaseFirestore.instance.collection('quiz-list').add({
        'id': '3',
        'label': 'Javascript',
        'description': 'This is java test'
      });
    }
  

  loadQuestionList() {
    loadQuestionListFor("1", "Java");
    loadQuestionListFor("2", ".Net");
    loadQuestionListFor("3", "Javascript");
  }

  loadQuestionListFor(String quizId, String quizName) {
    
      FirebaseFirestore.instance.collection('quiz-' + quizId).add({
        'label': quizName + " first question",
        'optionA': {'label': 'correct', 'marks': 1},
        'optionB': {'label': 'option B', 'marks': 0},
        'optionC': {'label': 'option C', 'marks': 0},
        'optionD': {'label': 'option D', 'marks': 0}
      });
      FirebaseFirestore.instance.collection('quiz-' + quizId).add({
        'label': quizName + " second question",
        'optionA': {'label': 'correct', 'marks': 1},
        'optionB': {'label': 'option B', 'marks': 0},
        'optionC': {'label': 'option C', 'marks': 0},
        'optionD': {'label': 'option D', 'marks': 0}
      });
      FirebaseFirestore.instance.collection('quiz-' + quizId).add({
        'label': quizName + " third question",
        'optionA': {'label': 'correct', 'marks': 1},
        'optionB': {'label': 'option B', 'marks': 0},
        'optionC': {'label': 'option C', 'marks': 0},
        'optionD': {'label': 'option D', 'marks': 0}
      });
      FirebaseFirestore.instance.collection('quiz-' + quizId).add({
        'label': quizName + " forth question",
        'optionA': {'label': 'correct', 'marks': 1},
        'optionB': {'label': 'option B', 'marks': 0},
        'optionC': {'label': 'option C', 'marks': 0},
        'optionD': {'label': 'option D', 'marks': 0}
      });
      FirebaseFirestore.instance.collection('quiz-' + quizId).add({
        'label': quizName + " fifth question",
        'optionA': {'label': 'correct', 'marks': 1},
        'optionB': {'label': 'option B', 'marks': 0},
        'optionC': {'label': 'option C', 'marks': 0},
        'optionD': {'label': 'option D', 'marks': 0}
      });
    }
  
}
