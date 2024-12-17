import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:component_library/component_library.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:activity_repository/activity_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:form_fields/form_fields.dart';

import 'profile_menu_bloc.dart';
import '../profile_menu.dart';

part './view_update_profile_menu.dart';

const double picDimension = 250;
const double picEditIconSize = 16;
const double modalBottomSheetTopRadius = 16;

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
    super.key,
  });

  final VoidCallback? onSignInTap;
  final VoidCallback? onSignUpTap;
  final VoidCallback? onFollowersTap;
  final VoidCallback? onFollowingTap;
  final VoidCallback? onPublicFavoritesTap;
  @override
  Widget build(BuildContext context) {
    final l10n = ProfileMenuLocalizations.of(context);
    return StyledStatusBar.dark(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<ProfileMenuBloc, ProfileMenuState>(
              builder: (context, state) {
                if (state is ProfileMenuLoaded) {
                  final username = state.username;
                  final picUrl = state.picUrl;
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
                                  onPressed: () => _showPicEditOptions(
                                    context,
                                    state,
                                    l10n,
                                  ),
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
                                    l10n.signInUserGreeting(username.value),
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
                      //TODO Display the account details if you request the user of the current user session
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
                      const SizedBox(
                        height: Spacing.medium,
                      ),
                      const ViewUpdateProfileMenu(),
                      const Divider(),
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
                  );
                } else {
                  return const CenteredCircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showPicEditOptions(
    BuildContext context,
    ProfileMenuState state,
    ProfileMenuLocalizations l10n,
  ) {
    final bloc = context.read<ProfileMenuBloc>();
    final wallpaperTheme = WallpaperDoubleQuotesTheme.maybeOf(context);
    final defaultTheme = DefaultDoubleQuotesTheme.maybeOf(context);

    Widget showThemeError(BuildContext context) {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'Error loading theme for showModalBottomSheet',
      );
    }

    if (wallpaperTheme != null) {
      wallpaperTheme.themeData.then(
        (theme) {
          buildShowModalBottomSheet(context, theme, l10n, state, bloc);
        },
        onError: (_) {
          showThemeError(context);
        },
      );
    } else if (defaultTheme != null) {
      buildShowModalBottomSheet(
        context,
        defaultTheme.materialThemeData,
        l10n,
        state,
        bloc,
      );
    } else {
      showThemeError(context);
    }
  }

  Future<dynamic> buildShowModalBottomSheet(
    BuildContext context,
    ThemeData theme,
    ProfileMenuLocalizations l10n,
    ProfileMenuState state,
    ProfileMenuBloc bloc,
  ) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surfaceContainerHigh,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(modalBottomSheetTopRadius),
        ),
      ),
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(seconds: 2),
        reverseDuration: const Duration(seconds: 1),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...ListTile.divideTiles(
              context: context,
              tiles: [
                CustomListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/facebook.svg',
                  ),
                  title: l10n.facebookTitle,
                  subtitle: l10n.setPicFromFacebookSubtitle,
                  onTap: () {
                    Navigator.of(context).pop;
                    if (state is ProfileMenuLoaded) {
                      if (state.facebookUsername == null) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            CustomSnackBar(
                              content: l10n.emptyFacebookUsernameErrorMessage,
                            ) as SnackBar,
                          );
                      } else {
                        bloc.add(
                          const ProfileMenuUpdatePic(Pic.facebook),
                        );
                      }
                    } else {
                      return;
                    }
                  },
                ),
                //Twitter X
                CustomListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/twitter-x.svg',
                  ),
                  title: l10n.xTitle,
                  subtitle: l10n.setPicFromXSubtitle,
                  onTap: () {
                    Navigator.of(context).pop;
                    if (state is ProfileMenuLoaded) {
                      if (state.xUsername == null) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            CustomSnackBar(
                              content: l10n.emptyXUsernameErrorMessage,
                            ) as SnackBar,
                          );
                      } else {
                        bloc.add(
                          const ProfileMenuUpdatePic(Pic.twitter),
                        );
                      }
                    } else {
                      return;
                    }
                  },
                ),
                //Email
                CustomListTile(
                  leading: const Icon(Icons.email),
                  title: l10n.emailGravaterTitle,
                  subtitle: l10n.setPicFromEmailSubtitle,
                  onTap: () {
                    Navigator.of(context).pop;
                    if (state is ProfileMenuLoaded) {
                      if (state.email == null) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              backgroundColor: theme.colorScheme.errorContainer,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              content: Text(
                                l10n.emptyEmailGravaterErrorMessage,
                                style: TextStyle(
                                  color: theme.colorScheme.onErrorContainer,
                                  fontSize: FontSize.medium,
                                ),
                              ),
                              duration: const Duration(seconds: 3),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                    snackBarTopRadius,
                                  ),
                                ),
                              ),
                              behavior: SnackBarBehavior.floating,
                              elevation: 4,
                            ),
                          );
                      } else {
                        bloc.add(
                          const ProfileMenuUpdatePic(Pic.gravater),
                        );
                      }
                    } else {
                      return;
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
