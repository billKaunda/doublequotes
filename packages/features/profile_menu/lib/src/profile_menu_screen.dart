import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:activity_repository/activity_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:user_repository/user_repository.dart';

import 'profile_menu_bloc.dart';
import '../profile_menu.dart';

part 'dark_mode_preference_picker.dart';
part 'language_preference_picker.dart';
part 'theme_source_preference_picker.dart';

const double picDimension = 250;
const double picEditIconSize = 16;

class ProfileMenuScreen extends StatelessWidget {
  const ProfileMenuScreen({
    required this.userRepository,
    required this.quoteRepository,
    required this.activityRepository,
    this.onSignInTap,
    this.onSignUpTap,
    this.onFollowersTap,
    this.onFollowingTap,
    this.onPublicFavoritesTap,
    this.onUpdateProfileTap,
    super.key,
  });

  final UserRepository userRepository;
  final QuoteRepository quoteRepository;
  final ActivityRepository activityRepository;
  final VoidCallback? onSignInTap;
  final VoidCallback? onSignUpTap;
  final VoidCallback? onFollowersTap;
  final VoidCallback? onFollowingTap;
  final VoidCallback? onPublicFavoritesTap;
  final VoidCallback? onUpdateProfileTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileMenuBloc>(
      create: (_) => ProfileMenuBloc(
        userRepository: userRepository,
        quoteRepository: quoteRepository,
        activityRepository: activityRepository,
      ),
      child: ProfileMenuView(
        onSignInTap: onSignInTap,
        onSignUpTap: onSignUpTap,
        onFollowersTap: onFollowersTap,
        onFollowingTap: onFollowingTap,
        onPublicFavoritesTap: onPublicFavoritesTap,
        onUpdateProfileTap: onUpdateProfileTap,
      ),
    );
  }
}

@visibleForTesting
class ProfileMenuView extends StatelessWidget {
  const ProfileMenuView({
    this.onSignInTap,
    this.onSignUpTap,
    this.onFollowersTap,
    this.onFollowingTap,
    this.onPublicFavoritesTap,
    this.onUpdateProfileTap,
    this.onSettingsMenuTap,
    super.key,
  });

  final VoidCallback? onSignInTap;
  final VoidCallback? onSignUpTap;
  final VoidCallback? onFollowersTap;
  final VoidCallback? onFollowingTap;
  final VoidCallback? onPublicFavoritesTap;
  final VoidCallback? onUpdateProfileTap;
  final VoidCallback? onSettingsMenuTap;

  @override
  Widget build(BuildContext context) {
    final l10n = ProfileMenuLocalizations.of(context);
    final bloc = context.read<ProfileMenuBloc>();
    final screenMargin =
        (WallpaperDoubleQuotesTheme.maybeOf(context)?.screenMargin ??
                DefaultDoubleQuotesTheme.maybeOf(context)?.screenMargin) ??
            Spacing.medium;

    return StyledStatusBar.dark(
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProfileMenuBloc, ProfileMenuState>(
            builder: (context, state) {
              if (state is ProfileMenuLoaded) {
                final username = state.username;
                final picUrl = state.picUrl;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      if (!state.isUserAuthenticated) ...[
                        SignInButton(
                          bloc: (context) => bloc.add(
                            const ProfileMenuStarted(),
                          ),
                          onSignInTap: onSignInTap,
                        ),
                        const SizedBox(
                          height: Spacing.xLarge,
                        ),
                        Text(
                          l10n.signUpOpeningText,
                        ),
                        TextButton(
                          onPressed: onSignUpTap,
                          child: Text(
                            l10n.signUpButtonLabel,
                          ),
                        ),
                        const SizedBox(
                          height: Spacing.large,
                        ),
                      ],
                      if (picUrl != null) ...[
                        SizedBox(
                          width: picDimension,
                          height: picDimension,
                          child: Stack(
                            children: [
                              //Circle Avatar
                              Container(
                                width: picDimension,
                                height: picDimension,
                                child: CustomCircleAvatar(
                                  imageUrl: state.picUrl,
                                  maxRadius: picDimension,
                                ),
                              ),
                              //Edit Button
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: EditPicSourceButton(
                                  onPressed: () => onUpdateProfileTap,
                                  iconSize: picEditIconSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (username != null) ...[
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(
                                Spacing.small,
                              ),
                              child: Stack(
                                alignment: Alignment
                                    .topRight, // Position the badge at the top-right corner
                                children: [
                                  ShrinkableText(
                                    l10n.signedInUserGreeting(username),
                                    style: const TextStyle(fontSize: 36),
                                  ),
                                  if (state
                                      .isProUser) // Check if the user is a pro user
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: SizedBox(
                                        width: 30, // Adjust size as needed
                                        height: 30,
                                        child: Image.asset(
                                          'assets/animations/verified.gif', // Path to your premium badge GIF
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Followers
                          CustomInkwell(
                            onTap: onFollowersTap,
                            number: state.followers ?? 0,
                            label: l10n.followersLabel,
                          ),
                          //following
                          CustomInkwell(
                            onTap: onFollowingTap,
                            number: state.following ?? 0,
                            label: l10n.followingLabel,
                          ),
                          //public favorites count
                          CustomInkwell(
                            onTap: onPublicFavoritesTap,
                            number: state.followers ?? 0,
                            label: l10n.publicFavoritesLabel,
                          ),
                        ],
                      ),
                      //TODO Display the account details if you request the user of the current user session
                      const SizedBox(
                        height: Spacing.medium,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenMargin,
                          ),
                          child: Column(
                            children: [
                              //Update Profile
                              CustomListTile(
                                leading: const Icon(
                                  Icons.person_2,
                                ),
                                title: l10n.updateProfileTitleLabel,
                                titleFontSize: FontSize.small,
                                titleFontWeight: FontWeight.bold,
                                subtitle: l10n.updateProfileSubtitleLabel,
                                subtitleFontSize: FontSize.medium,
                                onTap: onUpdateProfileTap,
                                dense: false,
                              ),
                              const SizedBox(
                                height: Spacing.medium,
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
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: Spacing.mediumLarge,
                      ),
                      if (state.isUserAuthenticated) ...[
                        const Spacer(),
                        SignOutButton(
                          isSignOutInProgress: state.isSignOutInProgress,
                          expandedElevatedButton: ExpandedElevatedButton(
                            onTap: () {
                              final bloc = context.read<ProfileMenuBloc>();
                              bloc.add(
                                const ProfileMenuSignedOut(),
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
                  ),
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
