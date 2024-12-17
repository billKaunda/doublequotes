import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalid, alreadyRegistered }

class Email extends FormzInput<String, EmailValidationError>
    with EquatableMixin {
  //Call super.pure to represent an unmodified form input
  const Email.unvalidated([super.value = ''])
      : isAlreadyRegistered = false,
        super.pure();

  //Call super.dirty to represent a modified form input
  const Email.validated(
    super.value, {
    this.isAlreadyRegistered = false,
  }) : super.dirty();

  final bool isAlreadyRegistered;

  static final _emailRegEx = RegExp(r'^('
      '([\\w-]+\\.)+[\\w-]+' //matches domain name, e.g, example.com
      '|'
      '([a-zA-Z]|[\\w-]{2,})' //matches single-word or TLDs such as com
      ')@'
      '(' //This second part of the pattern handles the domain
      '(' // part which can either be an IP address or a domain name
      '([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.' //Each segment of the IP
      '([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.'
      '([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.'
      '([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])'
      ')'
      '|' //Matches domain names (e.g subdomain.example.com) and allows
      '([a-zA-Z]+[\\w-]+\\.)+[a-zA-Z]{2,4})\$' // for subdomains and hyphens.
      );

  //override validator to handle validating a given input value
  @override
  EmailValidationError? validator(String value) {
    return value.isEmpty
        ? EmailValidationError.empty
        : (isAlreadyRegistered
            ? EmailValidationError.alreadyRegistered
            : (_emailRegEx.hasMatch(value)
                ? null
                : EmailValidationError.invalid));
  }

  @override
  List<Object?> get props => [
        value,
        isAlreadyRegistered,
      ];
}
