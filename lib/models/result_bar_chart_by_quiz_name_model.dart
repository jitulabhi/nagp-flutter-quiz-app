class ResultBarChartByQuizNameModel {
  late String _quizName;
  late int _count;

  String get quizName => _quizName;
  int get count => _count;

  ResultBarChartByQuizNameModel(String quizName, int count) {
    this._quizName = quizName;
    this._count = count;
  }
}
