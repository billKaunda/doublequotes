part of 'settings_menu_screen.dart';

class ThemeSourcePreferencePicker extends StatelessWidget {
  const ThemeSourcePreferencePicker({
    super.key,
    required this.currentValue,
  });

  final ThemeSourcePreference currentValue;
  @override
  Widget build(BuildContext context) {
    final l10n = SettingsMenuLocalizations.of(context);
    final bloc = context.read<SettingsMenuBloc>();
    return Column(
      children: [
        ...ListTile.divideTiles(
          context: context,
          tiles: [
            //Default
            CustomRadioListTile(
              title: l10n.defaultThemeTileLabel,
              value: ThemeSourcePreference.defaultTheme,
              groupValue: currentValue,
              onChanged: (value) {
                bloc.add(
                  const SettingsMenuThemeSourceChanged(
                    ThemeSourcePreference.defaultTheme,
                  ),
                );
                return ExpansionTileController.of(context).collapse();
              },
            ),
            //From Wallpaper
            CustomRadioListTile(
              title: l10n.themeFromMyWallpaperTileLabel,
              value: ThemeSourcePreference.fromWallpaper,
              groupValue: currentValue,
              onChanged: (value) {
                bloc.add(
                  const SettingsMenuThemeSourceChanged(
                    ThemeSourcePreference.fromWallpaper,
                  ),
                );
                return ExpansionTileController.of(context).collapse();
              },
            ),
          ],
        ),
      ],
    );
  }
}
