import 'dart:convert';

class User {
  int id;
  String username;
  String fullName;
  String password;
  bool isProfessional;

  User(
      {required this.id,
      required this.username,
      required this.fullName,
      required this.password,
      required this.isProfessional});

  @override
  String toString() {
    return '{${this.id},${this.username}, ${this.fullName}, ${this.password}, ${this.isProfessional} }';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
      'password': password,
      'isProfessional': isProfessional,
    };
  }

 

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
    id:map['id']??0,
      username:map['username'],
      fullName:map['full_name']??'',
      password:map['password']??'',
      isProfessional:map['is_professional']??false,
    );
  }
}
