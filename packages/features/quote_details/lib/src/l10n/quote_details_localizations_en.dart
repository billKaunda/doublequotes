import 'quote_details_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class QuoteDetailsLocalizationsEn extends QuoteDetailsLocalizations {
  QuoteDetailsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get quoteNotFoundErrorMessageTitle => 'Quote Not Found';

  @override
  String get quoteNotFoundErrorMessageBody => 'Ooopss, the requested quote cannot be retrieved, please try again.';

  @override
  String get addQuoteMenuItemButtonLabel => 'Add Quote';

  @override
  String get addTagToQuoteMenuItemButtonLabel => 'Add tag to quote';

  @override
  String get makeQuotePublicMenuItemButtonLabel => 'Make quote public';

  @override
  String get makeQuotePrivateMenuItemButtonLabel => 'Make quote private';

  @override
  String get cannotUnfavPrivateQuoteErrorMessage => 'Private quotes cannot be unfav\'d';

  @override
  String get userSessionNotFoundErrorMessage => 'Please sign in to continue';

  @override
  String get proUserRequiredErrorMessage => 'Upgrade to Pro';

  @override
  String get couldNotCreateQuoteErrorMessage => 'Ooopss, could not create quote';

  @override
  String get unknownAuthorPlaceholder => 'Unknown author';

  @override
  String get noContentAvailablePlaceholder => 'No content available';
}
