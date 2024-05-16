class LoginResponseModel {
  String? otp;
  bool? isUserAlreadyPresent;

  LoginResponseModel({String? otp, bool? isUserAlreadyPresent}) {
    if (otp != null) {
      this.otp = otp;
    }
    if (isUserAlreadyPresent != null) {
      this.isUserAlreadyPresent = isUserAlreadyPresent;
    }
  }

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      otp: json['otp'],
      isUserAlreadyPresent: json['userAlreadyPresent'],
    );
  }
}
