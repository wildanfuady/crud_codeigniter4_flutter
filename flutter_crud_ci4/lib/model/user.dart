import 'dart:convert';


class User {
  static const genders = ['pria', 'wanita'];
  static const grades = ['tk', 'sd', 'smp', 'sma'];

  int id;
  String fullName;
  String gender;
  String grade;
  String phone;

  User({this.id, this.fullName, this.gender, this.grade, this.phone});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map["id"], 
      fullName: map["fullname"], 
      gender: map["gender"], 
      grade: map["grade"],
      phone: map["phone"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id, 
      "fullname": fullName, 
      "gender": gender, 
      "grade": grade,
      "phone": phone
    };
  }

  @override
  String toString() {
    return 'User{id: $id, fullname: $fullName, gender: $gender, grade: $grade, phone: $phone}';
  }
}

List<User> userFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<User>.from(data.map((item) => User.fromJson(item)));
}

String userToJson(User data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}