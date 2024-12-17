import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

enum UsernameValidationError { empty, invalid, isAlreadyTaken }

class Username extends FormzInput<String, UsernameValidationError>
    with EquatableMixin {
  const Username.unvalidated([
    super.value = '',
  ])  : isAlreadyRegistered = false,
        super.pure();

  const Username.validated(
    super.value, {
    this.isAlreadyRegistered = false,
  }) : super.dirty();

  final bool isAlreadyRegistered;

  static final _usernameRegEx =
      RegExp(r'^(?=.{1,20}$)(?![_])(?!.*[_.]{2})[a-zA-Z_]+(?<![_])$');

  @override
  UsernameValidationError? validator(String value) {
    return value.isEmpty
        ? UsernameValidationError.empty
        : (isAlreadyRegistered
            ? UsernameValidationError.isAlreadyTaken
            : (_usernameRegEx.hasMatch(value)
                ? null
                : UsernameValidationError.invalid));
  }

  @override
  List<Object?> get props => [
        value,
        isAlreadyRegistered,
      ];
}
