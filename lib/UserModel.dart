class UserModel {
  String? firstName;
  String? lastName;
  String? regEmail;
  String? password;

  UserModel(this.firstName, this.lastName, this.regEmail, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'regEmail': regEmail,
      'password': password
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    firstName = map['firstName'];
    lastName = map['lastName'];
    regEmail = map['regEmail'];
    password = map['password'];
  }
}
