class QuizModel{
 late String _label;
 late String _id;

  String get label => _label;
  String get id => _id;
  

  QuizModel(String label, String id) {
   _label = label;
   _id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'id': id,
      
    };
  }


}