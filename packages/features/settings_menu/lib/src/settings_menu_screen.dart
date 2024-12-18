import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:component_library/component_library.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'l10n/settings_menu_localizations.dart';
import 'settings_menu_bloc.dart';

part 'dark_mode_preference_picker.dart';
part 'language_preference_picker.dart';
part 'theme_source_preference_picker.dart';

class SettingsMenuScreen extends StatelessWidget {
  const SettingsMenuScreen({
    super.key,
    required this.userRepository,
    required this.quoteRepository,
    this.onSignInTap,
    this.onSignUpTap,
  });

  final UserRepository userRepository;
  final QuoteRepository quoteRepository;
  final VoidCallback? onSignInTap;
  final VoidCallback? onSignUpTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsMenuBloc>(
      create: (context) => SettingsMenuBloc(
        userRepository: userRepository,
        quoteRepository: quoteRepository,
      ),
      child: SettingsMenuView(
        onSignInTap: onSignInTap,
        onSignUpTap: onSignUpTap,
      ),
    );
  }
}

class SettingsMenuView extends StatelessWidget {
  const SettingsMenuView({
    super.key,
    this.onSignInTap,
    this.onSignUpTap,
  });

  final VoidCallback? onSignInTap;
  final VoidCallback? onSignUpTap;

  @override
  Widget build(BuildContext context) {
    final l10n = SettingsMenuLocalizations.of(context);
    return StyledStatusBar.dark(
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<SettingsMenuBloc, SettingsMenuState>(
            builder: (context, state) {
              if (state is SettingsMenuLoaded) {
                final username = state.username;
                return Column(
                  children: [
                    if (!state.isUserAuthenticated) ...[
                      SignInButton(
                        onSignInTap: onSignInTap,
                      ),
                      const SizedBox(
                        height: Spacing.xLarge,
                      ),
                      Text(
                        l10n.signUpOpeningText,
                      ),
                      TextButton(
                        child: Text(
                          l10n.signUpButtonLabel,
                        ),
                        onPressed: onSignUpTap,
                      ),
                      const SizedBox(
                        height: Spacing.large,
                      ),
                    ],
                    if (username != null) ...[
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(
                              Spacing.small,
                            ),
                            child: ShrinkableText(
                              l10n.signedInUserGreeting(username),
                              style: const TextStyle(
                                fontSize: 36,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                    const SizedBox(
                      height: Spacing.mediumLarge,
                    ),
                    //Default & Wallpaper theming options
                    CustomExpansionTile(
                      title: l10n.themeSettingsTileLabel,
                      subtitle: state.themeSourcePreference.toTitleCase(),
                      children: [
                        Builder(
                          builder: (context) => ThemeSourcePreferencePicker(
                            currentValue: state.themeSourcePreference,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Spacing.mediumLarge,
                    ),
                    //Dark Mode Preference
                    ChevronListTile(
                      title: l10n.darkModePreferencesListTileLabel,
                      subtitle: state.darkModePreference.toTitleCase(),
                      onTap: () => DarkModePreferencePicker(
                        currentValue: state.darkModePreference,
                      ),
                    ),
                    const SizedBox(
                      height: Spacing.mediumLarge,
                    ),
                    //Language
                    ChevronListTile(
                      title: l10n.languageListTileLabel,
                      subtitle: state.languagePreference.toTitleCase(),
                      onTap: () => LanguagePreferencePicker(
                        currentValue: state.languagePreference,
                      ),
                      leading: const Icon(
                        Icons.language_rounded,
                      ),
                    ),
                    if (state.isUserAuthenticated) ...[
                      const Spacer(),
                      SignOutButton(
                        isSignOutInProgress: state.isSignOutInProgress,
                        expandedElevatedButton: ExpandedElevatedButton(
                          onTap: () {
                            final bloc = context.read<SettingsMenuBloc>();
                            bloc.add(
                              const SettingsMenuSignedOut(),
                            );
                          },
                          label: l10n.signOutButtonLabel,
                          icon: const Icon(
                            Icons.logout,
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              } else {
                return const CenteredCircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

extension on DarkModePreference {
  String toTitleCase() {
    //Convert enum name to a string and split by camel case
    final words = name.split(RegExp(r'(?=[A-Z])'));

    //convert each word to lowercase and capitalize the first letter
    final titleCased = words
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : word)
        .join(' ');

    return titleCased;
  }
}

extension on LanguagePreference {
  String toTitleCase() {
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }
}

extension on ThemeSourcePreference {
  String toTitleCase() {
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }
}
