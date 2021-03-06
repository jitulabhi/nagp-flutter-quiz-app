import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/models/answers_model.dart';
import 'package:quizapp/models/profile_model.dart';
import 'package:quizapp/models/question_option_model.dart';
import 'package:quizapp/models/quiz-model.dart';

import '../models/question_model.dart';

class Repository {
  Stream<List<QuizModel>> getQuizList() {
    return FirebaseFirestore.instance
        .collection('quiz-list')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => QuizModel(doc['label'], doc['id'], doc['description']))
          .toList();
    });
  }

  Stream<List<QuestionModel>> getQuestionList(String id) {
    return FirebaseFirestore.instance
        .collection('quiz-' + id)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => QuestionModel(
              doc['label'],
              QuestionOptionModel(
                  doc['optionA']['label'], doc['optionA']['marks']),
              QuestionOptionModel(
                  doc['optionB']['label'], doc['optionB']['marks']),
              QuestionOptionModel(
                  doc['optionC']['label'], doc['optionC']['marks']),
              QuestionOptionModel(
                  doc['optionD']['label'], doc['optionD']['marks'])))
          .toList();
    });
  }

  saveQuestionAnswer(AnswerModel model) {
    FirebaseFirestore.instance.collection("answers").add(model.toJson());
  }

  Stream<List<AnswerModel>> getAnswerList(String profileId) {
    return FirebaseFirestore.instance
        .collection('answers')
        .where('profileId', isEqualTo: profileId)
        .orderBy("quiz.id", descending: false)
        .orderBy("quizId", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AnswerModel(
              doc['profileId'],
              doc['quizId'],
              QuizModel(doc['quiz']['label'], doc['quiz']['id'], doc['quiz']['description'] ?? ''),
              doc['questionLabel'],
              QuestionOptionModel(doc['optionSelected']['label'],
                  doc['optionSelected']['marks'])))
          .toList();
    });
  }

  Stream<List<ProfileModel>> getProfile(String profileId) {
    return FirebaseFirestore.instance
        .collection("profiles")
        .where("profileId", isEqualTo: profileId)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapShot) {
      return snapShot.docs
          .map((doc) => ProfileModel(
              doc['createdAt'],
              doc['profileId'],
              doc['name'],
              doc['designation'],
              doc['phone'],
              doc['location'],
              doc['description']))
          .toList();
    });
  }

  saveOrUpdateProfile(ProfileModel model) {
    FirebaseFirestore.instance.collection("profiles").add(model.toJson());
  }
}
