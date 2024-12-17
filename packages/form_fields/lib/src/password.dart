import 'package:formz/formz.dart';

enum PasswordValidationError { empty, invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.unvalidated([
    super.value = '',
    this.togglePasswordVisibility = false,
  ]) : super.pure();

  const Password.validated(
    super.value, {
    this.togglePasswordVisibility = false,
  }) : super.dirty();

  final bool togglePasswordVisibility;

  //This method copies a password instance with new visibility state
  Password copyWith({bool? togglePasswordVisibility}) {
    return Password.validated(
      value,
      togglePasswordVisibility:
          togglePasswordVisibility ?? this.togglePasswordVisibility,
    );
  }

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (value.length < 5 || value.length > 120) {
      return PasswordValidationError.invalid;
    } else {
      //return null if the form field is valid
      return null;
    }
  }
}
