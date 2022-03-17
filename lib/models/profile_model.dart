class ProfileModel {
  late String _profileId;
  late String _name;
  late String _designation;
  late String _phone;
  late String _location;
  late String _description;
  late int _createdAt;

String get profileId => _profileId;
  String get name => _name;
  String get designation => _designation;
  String get phone => _phone;
  String get location => _location;
  String get description => _description;
   int get createdAt => _createdAt;

  ProfileModel(int createdAt, String profileId, String name, String designation, String phone, String location, String description) {
    this._name = name;
    this._designation = designation;
    this._phone = phone;
    this._location = location;
    this._description = description;
    this._profileId = profileId;
    this._createdAt = createdAt;
  }

  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
      'name': name,
      'designation': designation,
      'phone': phone,
      'location': location,
      'description': description,
      'createdAt': createdAt
    };
  }

  
}