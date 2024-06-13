// validators.dart

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name is required';
  }
  return null; // No error
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegExp.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null; // No error
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
    return 'Password must contain at least one special character';
  }
  return null; // No error
}
