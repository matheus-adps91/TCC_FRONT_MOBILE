class Signup {
  String email;
  String password;
  String fullName;
  String gender;
  String address;
  String houseNumber;
  String state;
  String city;
  String zipCode;
  String compliance;

  Signup(
      {this.email,
      this.password,
      this.fullName,
      this.gender,
      this.address,
      this.houseNumber,
      this.state,
      this.city,
      this.zipCode,
      this.compliance});

  Signup.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    fullName = json['fullName'];
    gender = json['gender'];
    address = json['address'];
    houseNumber = json['houseNumber'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zipCode'];
    compliance = json['compliance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['houseNumber'] = this.houseNumber;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zipCode'] = this.zipCode;
    data['compliance'] = this.compliance;
    return data;
  }
}
