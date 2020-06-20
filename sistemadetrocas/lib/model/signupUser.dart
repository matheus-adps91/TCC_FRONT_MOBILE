class SignupUser {

  String email;
  String password;
  String fullName;
  String gender;
  String address;
  String houseNumber;
  String state;
  String city;
  String zipCode;
  String complement;
  bool compliance;
  int id;

  SignupUser(
      {this.email,
      this.password,
      this.fullName,
      this.gender,
      this.address,
      this.houseNumber,
      this.state,
      this.city,
      this.zipCode,
      this.complement,
      this.compliance,
      this.id});

  String get gEmail => email;
  String get gPassword => password;
  String get gFullName => fullName;
  String get gGender => gender;
  String get gAddress => address;
  String get gHouseNumber => houseNumber;
  String get gState => state;
  String get gCity => city;
  String get gZipCode => zipCode;
  String get gComplement => complement;
  bool get gCompliance => compliance;
  int get gUserId => id;

  // Converter o objeto JSON enviado do servidor para o meu modelo
  SignupUser.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    email = json['email'],
    password = json['password'],
    fullName = json['fullName'],
    gender = json['gender'],
    address = json['address'],
    houseNumber = json['houseNumber'],
    state = json['state'],
    city = json['city'],
    zipCode = json['zipCode'],
    complement = json['complement'],
    compliance = json['compliance'];


  // Converte o objeto do meu modelo para um mapa
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['houseNumber'] = this.houseNumber;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zipCode'] = this.zipCode;
    data['complement'] = this.complement;
    data['compliance'] = this.compliance;
    return data;
  }
}
