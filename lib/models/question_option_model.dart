class QuestionOptionModel {
  late String _label;
  late int _marks;

  String get label => _label;
  int get marks => _marks;

  QuestionOptionModel(String label, int marks) {
   _label = label;
   _marks = marks;
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'marks': marks,
      
    };
  }
}