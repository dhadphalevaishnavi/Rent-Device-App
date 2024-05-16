class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  int? mobile;

  User(
      {String? id,
      String? firstName,
      String? lastName,
      String? email,
      int? mobile}) {
    if (id != null) {
      this.id = id;
    }
    if (firstName != null) {
      this.firstName = firstName;
    }
    if (lastName != null) {
      this.lastName = lastName;
    }
    if (email != null) {
      this.email = email;
    }
    if (mobile != null) {
      this.mobile = mobile;
    }
  }

 factory User.fromJson(Map<String, dynamic> json) {
    return User(
    id : json['id'],
    firstName : json['firstName'],
    lastName :json['lastName'],
    email : json['email'],
    mobile : json['mobile'],);
  }

  Map<String,dynamic> toJson(){
    return{
      'id': id,
      'firstName':firstName,
      'lastName':lastName,
      'email':email,
      'mobile':mobile,
    };
  }

}
