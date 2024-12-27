part of 'profile_menu_screen.dart';

class LanguagePreferencePicker extends StatelessWidget {
  const LanguagePreferencePicker({
    super.key,
    required this.currentValue,
  });

  final LanguagePreference currentValue;

  @override
  Widget build(BuildContext context) {
    final l10n = ProfileMenuLocalizations.of(context);
    final bloc = context.read<ProfileMenuBloc>();
    return CustomSimpleDialog(
      //Language
      title: l10n.languagePrefSimpleDialogTitle,
      children: [
        ...ListTile.divideTiles(
          context: context,
          tiles: [
            //English
            CustomRadioListTile<LanguagePreference>(
              title: l10n.englishLanguageOptionLabel,
              value: LanguagePreference.english,
              groupValue: currentValue,
              onChanged: (value) => bloc.add(
                const ProfileMenuLanguagePrefChanged(
                  LanguagePreference.english,
                ),
              ),
            ),
            //Swahili
            CustomRadioListTile<LanguagePreference>(
              title: l10n.swahiliLanguageOptionLabel,
              value: LanguagePreference.swahili,
              groupValue: currentValue,
              onChanged: (value) => bloc.add(
                const ProfileMenuLanguagePrefChanged(
                  LanguagePreference.swahili,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
