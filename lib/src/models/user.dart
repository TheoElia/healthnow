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
<<<<<<< HEAD
      required this.password,
      required this.isProfessional});
=======
      required this.password});
>>>>>>> 336e6c68b3e9a75d72c79d78c3c47cb91eb6c087

  factory User.fromJson(dynamic json) {
    return User(
        id: json['id'],
        username: json['username'] as String,
        fullName: json['full_name'] as String,
        password: json['password'] as String,
        isProfessional: json['is_professional'] as bool);
  }

  @override
  String toString() {
    return '{${this.id},${this.username}, ${this.fullName}, ${this.password}, ${this.isProfessional} }';
  }
}
