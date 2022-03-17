class QuizModel{
 late String _label;
 late String _id;
 late String _description;

  String get label => _label;
  String get id => _id;
  String get description => _description;
  

  QuizModel(String label, String id, String description) {
   _label = label;
   _id = id;
   _description = description;
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'id': id,
      'description': description
      
    };
  }


}