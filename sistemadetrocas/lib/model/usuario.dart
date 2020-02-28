class Usuario {
  String token;
  String email;
  String fullName;

  Usuario(this.token, this.email, this.fullName);

  @override
  String toString() {
    return 'Usuário{token: $token, email: $email, fullName: $fullName}';
  }
}
