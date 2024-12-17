import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

enum XFaUsernameValidationError { empty, invalid }

class XFaUsername extends FormzInput<String, XFaUsernameValidationError>
    with EquatableMixin {
  const XFaUsername.unvalidated([
    super.value = '',
  ]) : super.pure();

  const XFaUsername.validated([
    super.value = '',
  ]) : super.dirty();

  static final _xFaUsernameRegEx = RegExp(r'^(?:@)?[a-zA-Z0-9._]{4,15}$');

  @override
  XFaUsernameValidationError? validator(String value) {
    return value.isEmpty
        ? XFaUsernameValidationError.empty
        : _xFaUsernameRegEx.hasMatch(value)
            ? null
            : XFaUsernameValidationError.invalid;
  }

  @override
  List<Object?> get props => [
        value,
      ];
}
