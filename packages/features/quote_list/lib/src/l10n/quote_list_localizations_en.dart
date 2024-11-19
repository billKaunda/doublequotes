import 'quote_list_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class QuoteListLocalizationsEn extends QuoteListLocalizations {
  QuoteListLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get quoteListRefreshErrorMessage => 'We couldn\'t refresh your items.\nPlease check your internet connectivity and then try again.';

  @override
  String get favoritesChoiceChipLabel => 'Favorites';

  @override
  String get authorChoiceChipLabel => 'Author';

  @override
  String get tagChoiceChipLabel => 'Tag';

  @override
  String get hiddenChoiceChipLabel => 'Hidden';

  @override
  String get privateChoiceChipLabel => 'Private';

  @override
  String get noQuoteBodyErrorMessage => 'No Quote Body Found';

  @override
  String get firstPageFetchErrorMessageTitle => 'First Page Fetch Error';

  @override
  String get firstPageFetchErrorMessageBody => 'Error loading the first page. Please, tap Try Again';

  @override
  String get proUserRequiredErrorMessage => 'Upgrade to Pro';
}
