class Validator {
  static String? nameValidator(value, text) {
    if (value!.isEmpty) {
      return 'Please enter $text';
    }
    else{
      return null;
    }
  }
}
