class Validation {
  static String? emailValidator(value) {
    if (value.isEmpty) {
      return 'Please enter an email address';
    }

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&'
      r'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    }

    return null;
  }

  static String? passwordValidator(value) {
    if (value.length >= 6 && value != null) {
      return null;
    } else {
      return 'Enter minimum 6 characters';
    }
  }


}
