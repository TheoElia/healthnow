class User {
  int id;
  String username;
  String fullName;
  String phone;
  String password;

  User(
      {required this.id,
      required this.username,
      required this.fullName,
      required this.phone,
      required this.password});

  factory User.fromJson(dynamic json) {
    return User(
        id: json['id'],
        username: json['username'] as String,
        fullName: json['full_name'] as String,
        phone: json['phone'] as String,
        password: json['password'] as String);
  }

  @override
  String toString() {
    return '{${this.username}, ${this.fullName}, ${this.phone}, ${this.password} }';
  }
}
