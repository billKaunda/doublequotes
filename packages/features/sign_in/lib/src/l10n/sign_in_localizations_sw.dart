import 'sign_in_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class SignInLocalizationsSw extends SignInLocalizations {
  SignInLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get invalidCredentialsErrorMessage => 'Barua pepe na/au nenosiri si sahihi.';

  @override
  String get inactiveUsernameErrorMessage => 'Jina la mtumiaji halitumiki. Wasiliana na support@favqs.com';

  @override
  String get missingCredentialsErrorMessage => 'Jina la mtumiaji au nenosiri halipo';

  @override
  String get sessionNotFoundErrorMessage => 'Kipindi cha mtumiaji hakijapatikana';

  @override
  String get userNotFoundErrorMessage => 'Mtumiaji hajapatikana';

  @override
  String get appBarTitle => 'Weka sahihi';

  @override
  String get emailTextFieldLabel => 'Barua Pepe';

  @override
  String get emailTextFieldEmptyErrorMessage => 'Barua pepe yako haiwezi kuwa tupu.';

  @override
  String get emailTextFieldInvalidErrorMessage => 'Barua pepe yako si sahihi.';

  @override
  String get passwordTextFieldLabel => 'Nenosiri';

  @override
  String get passwordTextFieldEmptyErrorMessage => 'Nenosiri lako haliwezi kuwa tupu.';

  @override
  String get passwordTextFieldInvalidErrorMessage => 'Nenosiri lazima liwe na urefu wa angalau vibambo 5.';

  @override
  String get forgotMyPasswordButtonLabel => 'Nimesahau nenosiri langu';

  @override
  String get signInButtonLabel => 'Weka sahihi';

  @override
  String get signUpOpeningText => 'Je, huna akaunti? Bonyeza hapa.';

  @override
  String get signUpButtonLabel => 'Jisajili';
}
