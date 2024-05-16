
import 'package:email_validator/email_validator.dart';

class TextFieldValidationService{

  static String? validateEmail(String? email){
    if(email!.isEmpty){
      return "";
    }
    if(!EmailValidator.validate(email!)){
      return "email id is invalid!";
    }
    return null;
  }

  static String? nameValidator(String? name){

    if(name!.length<2 ){
      return "Name should be minimum 2 characters long";
    }
    return null;
  }

  static String? mobileValidator(String? mobileNumber){
    if(mobileNumber == ""){
      return null;
    }
    if(mobileNumber! .length<10){
      return "Mobile number must be 10 digits";
    }
    return null;
  }

  static String? otpBaxValidator(String? digit){
    if(digit == ""){
      return "";
    }
    return null;
  }

}