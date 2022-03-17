class ResultBarChartModel {
  late int _attempted;
  late int _correct;
  late int _incorrect;

  int get attempted => _attempted;
  int get correct => _correct;
  int get incorrect => _incorrect;

ResultBarChartModel(int correct, int incorrect){
  _attempted = correct + incorrect;
  _correct = correct;
  _incorrect = incorrect;
}

}