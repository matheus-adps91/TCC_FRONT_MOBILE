class User
{
  String token;
  String email;
  String fullName;
  int id;

  User(this.token, this.email, this.fullName, this.id);

  @override
  String toString() {
    return 'Usuário{token: $token, email: $email, fullName: $fullName, id: $id}';
  }
}
