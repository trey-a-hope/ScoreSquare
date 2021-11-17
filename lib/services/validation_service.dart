abstract class IValidationService {
  String? isEmpty(String? value);
  String? mobile(String? value);
  String? email(String? value);
  String? password(String? value);
  String? state(String? value);
  String? zip(String? value);
  String? cardNumber(String? value);
  String? cardExpiration(String? value);
  String? cardCVC(String value);
}

class ValidationService extends IValidationService {
  @override
  String? isEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return ('Field cannot be empty.');
    } else {
      return null;
    }
  }

  @override
  String? mobile(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return null;
    } else if (!regExp.hasMatch(value)) {
      return 'Enter valid number or leave blank.';
    }
    return null;
  }

  @override
  String? email(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value == null || !regex.hasMatch(value)) {
      return 'Enter a valid email.';
    } else {
      return null;
    }
  }

  @override
  String? password(String? value) {
    String pattern = '.{6,}';
    RegExp regex = RegExp(pattern);
    if (value == null || !regex.hasMatch(value)) {
      return 'Enter 6 characters minimum.';
    } else {
      return null;
    }
  }

  @override
  String? state(String? value) {
    if (value == null || value.isEmpty) return 'Invalid state.';
    final RegExp regExp = RegExp(r'^[a-zA-Z]{2}$');
    if (!regExp.hasMatch(value)) return 'Must be 2 letters.';
    return null;
  }

  @override
  String? zip(String? value) {
    if (value == null || value.isEmpty) return 'Invalid zip.';
    final RegExp regExp = RegExp(r'^[0-9]{5}$');
    if (!regExp.hasMatch(value)) return 'Must be 5 digits.';
    return null;
  }

  @override
  String? cardNumber(String? value) {
    if (value == null || value.isEmpty) return 'Invalid card number.';
    final RegExp regExp = RegExp(r'^[0-9]{16}$');
    if (!regExp.hasMatch(value)) return 'Must be 16 numbers.';
    return null;
  }

  @override
  String? cardExpiration(String? value) {
    if (value == null || value.isEmpty) return 'Invalid expiration.';
    final RegExp regExp = RegExp(r'^[0-9]{4}$');
    if (!regExp.hasMatch(value)) return 'Must be 4 numbers.';
    return null;
  }

  @override
  String? cardCVC(String? value) {
    if (value == null || value.isEmpty) return 'Invalid CVC.';
    final RegExp regExp = RegExp(r'^[0-9]{3}$');
    if (!regExp.hasMatch(value)) return 'Must be 3 numbers.';
    return null;
  }
}
