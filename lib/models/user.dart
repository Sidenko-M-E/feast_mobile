class User {
  User(
      {required this.name,
      required this.email,
      this.phone,
      required this.password,
      required this.accessToken});

  String name;
  String email;
  String? phone;
  String password;
  String accessToken;
}
