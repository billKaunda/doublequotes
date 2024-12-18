part of './settings_menu_screen.dart';

class DarkModePreferencePicker extends StatelessWidget {
  const DarkModePreferencePicker({
    super.key,
    required this.currentValue,
  });

  final DarkModePreference currentValue;

  @override
  Widget build(BuildContext context) {
    final l10n = SettingsMenuLocalizations.of(context);
    final bloc = context.read<SettingsMenuBloc>();

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
                const SettingsMenuDarkModePrefChanged(
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
                const SettingsMenuDarkModePrefChanged(
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
                const SettingsMenuDarkModePrefChanged(
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
                const SettingsMenuDarkModePrefChanged(
                  DarkModePreference.highContrastLight,
                ),
              ),
            ),
            //Use system settings dark mode preference
            CustomRadioListTile<DarkModePreference>(
              title: l10n.useSystemSettingsOptionTileLabel,
              value: DarkModePreference.accordingToSystemSettings,
              groupValue: currentValue,
              onChanged: (value) => bloc.add(
                const SettingsMenuDarkModePrefChanged(
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
