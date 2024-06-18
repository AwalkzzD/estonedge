// validators.dart

import 'package:estonedge/base/constants/app_constants.dart';

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
  if (value.length < passwordLength) {
    return 'Password must be at least 8 characters long';
  }
  return null; // No error
}

String? validateSSID(String? value) {
  if (value == null || value.isEmpty) {
    return 'ID is required';
  }
  if (value.length < ssidLength || value.length > ssidLength) {
    return 'Length must be 12 characters long';
  }
  return null; // No error
}
