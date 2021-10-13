class User {
  int id;
  String username;
  String fullName;
  String password;

<<<<<<< HEAD
  User({required this.username,required this.fullName, required this.password});
=======
  User(
      {required this.id,
      required this.username,
      required this.fullName,
      required this.phone,
      required this.password});
>>>>>>> 4c655c8e72c7a6a076deed029cf1aafb4a5196dc

  factory User.fromJson(dynamic json) {
    return User(
        id: json['id'],
        username: json['username'] as String,
        fullName: json['full_name'] as String,
        password: json['password'] as String);
  }

  @override
  String toString() {
    return '{${this.username}, ${this.fullName}, ${this.password} }';
  }
}
