class User {
  String token;
  String email;
  String fullName;

  User(this.token, this.email, this.fullName);

  @override
  String toString() {
    return 'Usuário{token: $token, email: $email, fullName: $fullName}';
  }
}
