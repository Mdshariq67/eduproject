String? loginValidatePassword(String? password) {
  if (password == null) {
    return null;
  }

  if (password.isEmpty) {
    return 'Password can\'t be empty';
  } else if (password.length < 6) {
    return 'Enter a password with length at least 6';
  }

  return null;
}




String? loginValidateEmail(String? value) {
  const pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  final regex = RegExp(pattern);
  if (value!.isEmpty) {
    return 'Email can\'t be empty';
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}
