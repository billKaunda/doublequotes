part of './profile_menu_screen.dart';

class DarkModePreferencePicker extends StatelessWidget {
  const DarkModePreferencePicker({
    super.key,
    required this.currentValue,
  });

  final DarkModePreference currentValue;

  @override
  Widget build(BuildContext context) {
    final l10n = ProfileMenuLocalizations.of(context);
    final bloc = context.read<ProfileMenuBloc>();

    return CustomSimpleDialog(
      title: l10n.darkModePrefSimpleDialogTitle,
      children: [
        ...ListTile.divideTiles(
          context: context,
          tiles: [
            //High Contrast Dark mode
            CustomRadioListTile<DarkModePreference>(
              title: l10n.highContrastDarkOptionLabel,
              value: DarkModePreference.highContrastDark,
              groupValue: currentValue,
              onChanged: (value) => bloc.add(
                const ProfileMenuDarkModePrefChanged(
                  DarkModePreference.highContrastDark,
                ),
              ),
            ),
            //Dark tile label
            CustomRadioListTile<DarkModePreference>(
              title: l10n.darkOptionTileLabel,
              value: DarkModePreference.dark,
              groupValue: currentValue,
              onChanged: (value) =>  bloc.add(
                const ProfileMenuDarkModePrefChanged(
                  DarkModePreference.dark,
                ),
              ),
            ),
            //Light mode
            CustomRadioListTile<DarkModePreference>(
              title: l10n.lightOptionTileLabel,
              value: DarkModePreference.light,
              groupValue: currentValue,
              onChanged: (value) => bloc.add(
                const ProfileMenuDarkModePrefChanged(
                  DarkModePreference.light,
                ),
              ),
            ),
            //High Contrast Light tile label
            CustomRadioListTile<DarkModePreference>(
              title: l10n.highContrastLightOptionTileLabel,
              value: DarkModePreference.highContrastLight,
              groupValue: currentValue,
              onChanged: (value) => bloc.add(
                const ProfileMenuDarkModePrefChanged(
                  DarkModePreference.highContrastLight,
                ),
              ),
            ),
            //Use system Profile dark mode preference
            CustomRadioListTile<DarkModePreference>(
              title: l10n.useSystemSettingsOptionTileLabel,
              value: DarkModePreference.accordingToSystemSettings,
              groupValue: currentValue,
              onChanged: (value) => bloc.add(
                const ProfileMenuDarkModePrefChanged(
                  DarkModePreference.accordingToSystemSettings,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
