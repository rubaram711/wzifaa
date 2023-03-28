

bool isNotCorrectPassword(String value){
  if(value.length < 6 ||
      !value.contains(RegExp(r'[A-Za-z]')) ||
      !value.contains(RegExp(r'[0-9]'))){return true;}
  return false;
}



bool isNotCorrectEmail(String value){
  if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)){return false;}
  return true;
}



