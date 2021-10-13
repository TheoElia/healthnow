class User {
  String username;
  String fullName;
  String password;

  User({required this.username,required this.fullName, required this.password});

  factory User.fromJson(dynamic json) {
    return User(
        username:json['username'] as String,
        fullName: json['full_name'] as String,
        password: json['password'] as String);
  }

  @override
  String toString() {
    return '{${this.username}, ${this.fullName}, ${this.password} }';
  }
}
