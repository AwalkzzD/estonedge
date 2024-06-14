String? validateEmail(String? value) {
  if (value!.trim().isEmpty) {
    return "Email is invalid";
  }
/*  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return string("error_email_invalid");
  }*/
  return null;
}