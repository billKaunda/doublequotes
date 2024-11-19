import 'quote_list_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class QuoteListLocalizationsSw extends QuoteListLocalizations {
  QuoteListLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get quoteListRefreshErrorMessage => 'Hatukuweza kuonyesha upya vipengee vyako.\nTafadhali angalia muunganisho wako wa mtandao kisha ujaribu tena.';

  @override
  String get favoritesChoiceChipLabel => 'Vipendwa';

  @override
  String get authorChoiceChipLabel => 'Mwandishi';

  @override
  String get tagChoiceChipLabel => 'Tagi';

  @override
  String get hiddenChoiceChipLabel => 'Zilizofichwa';

  @override
  String get privateChoiceChipLabel => 'Za kibinafsi';

  @override
  String get noQuoteBodyErrorMessage => 'Hakuna mwili wa nukuu uliopatikana';

  @override
  String get firstPageFetchErrorMessageTitle => 'Hitilafu ya Kuleta Ukurasa wa Kwanza';

  @override
  String get firstPageFetchErrorMessageBody => 'Hitilafu katika kupakia ukurasa wa kwanza. Tafadhali, jaribu tena';

  @override
  String get proUserRequiredErrorMessage => 'Pata toleo jipya la Pro';
}
