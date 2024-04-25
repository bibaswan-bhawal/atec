class Validators {
  static String? isEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    return null;
  }
}
