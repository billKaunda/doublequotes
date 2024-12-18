import 'quote_details_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class QuoteDetailsLocalizationsSw extends QuoteDetailsLocalizations {
  QuoteDetailsLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get quoteNotFoundErrorMessageTitle => 'Nukuu Haijapatikana';

  @override
  String get quoteNotFoundErrorMessageBody => 'Samahani, nukuu uliyoomba haiwezi kurejeshwa. Tafadhali, jaribu tena.';

  @override
  String get addQuoteMenuItemButtonLabel => 'Ongeza nukuu';

  @override
  String get addTagToQuoteMenuItemButtonLabel => 'Ongeza lebo kwa nukuu';

  @override
  String get makeQuotePublicMenuItemButtonLabel => 'Weka nukuu hadharani';

  @override
  String get makeQuotePrivateMenuItemButtonLabel => 'Fanya nukuu iwe ya faragha';

  @override
  String get cannotUnfavPrivateQuoteErrorMessage => 'Nukuu za kibinafsi haziwezi kutenduliwa';

  @override
  String get userSessionNotFoundErrorMessage => 'Tafadhali jisajili ili endelee';

  @override
  String get proUserRequiredErrorMessage => 'Pata toleo jipya la Pro';

  @override
  String get couldNotCreateQuoteErrorMessage => 'Samahani, hatukuweza kuunda nukuu';

  @override
  String get unknownAuthorPlaceholder => 'Mwandishi hajulikani';

  @override
  String get noContentAvailablePlaceholder => 'Hakuna maudhui yanayopatikana';
}
