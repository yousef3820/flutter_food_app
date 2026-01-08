class Errors {
  final List<String>? email;
  final List<String>? password;

  Errors({this.email, this.password});

  factory Errors.fromjson(Map<String, dynamic> json) {
    return Errors(
      email: json["email"] != null
          ? List<String>.from(json["email"])
          : null,
      password: json["password"] != null
          ? List<String>.from(json["password"])
          : null,
    );
  }
}