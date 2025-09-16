import 'dart:convert';

class Validators {
  static String? emailValidator(
    String? email,
  ) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(email!))
        ? "Veuillez remplir correctement ce champ"
        : null;
  }

  static String? lengthValidator(String? value) {
    if (value!.length < 4) {
      return "Ce champ doit avoir 4 caractères au minimum";
    }
    return null;
  }

  static String? numberValidator(String? value) {
    if (double.tryParse(value!) == null) {
      return "Ce champ doit contenir des nombres uniquement";
    }
    return null;
  }

  static String handleNetworkErrors({required String body}) {
    return jsonDecode(body)['message'] is List
        ? jsonDecode(body)['message']?.join(', ')
        : jsonDecode(body)['message'] is String
            ? jsonDecode(body)['message']
            : 'Une erreur est survenue';
  }
}
