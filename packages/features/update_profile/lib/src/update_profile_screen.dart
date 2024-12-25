import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:component_library/component_library.dart';
import 'package:user_repository/user_repository.dart';
import 'package:form_fields/form_fields.dart';

import './l10n/update_profile_localizations.dart';
import 'update_profile_cubit.dart';

const double modalBottomSheetTopRadius = 16;

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({
    required this.userRepository,
    required this.onUpdateProfileSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onUpdateProfileSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpdateProfileCubit>(
      create: (_) => UpdateProfileCubit(
        userRepository: userRepository,
      ),
      child: UpdateProfileView(
        onUpdateProfileSuccess: onUpdateProfileSuccess,
      ),
    );
  }
}

class UpdateProfileView extends StatelessWidget {
  const UpdateProfileView({
    required this.onUpdateProfileSuccess,
    super.key,
  });

  final VoidCallback onUpdateProfileSuccess;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _releaseFocus(context),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text(
            UpdateProfileLocalizations.of(context).appBarTitle,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: Spacing.mediumLarge,
            left: Spacing.mediumLarge,
            right: Spacing.mediumLarge,
          ),
          child: _UpdateProfileForm(
            onUpdateProfileSuccess: onUpdateProfileSuccess,
          ),
        ),
      ),
    );
  }

  void _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();
}

class _UpdateProfileForm extends StatefulWidget {
  const _UpdateProfileForm({
    required this.onUpdateProfileSuccess,
  });

  final VoidCallback onUpdateProfileSuccess;

  @override
  State<_UpdateProfileForm> createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<_UpdateProfileForm> {
  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordConfirmationFocusNode = FocusNode();
  final _xUsernameFocusNode = FocusNode();
  final _fbUsernameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _usernameFocusNode.addListener(() {
      if (!_usernameFocusNode.hasFocus) {
        final cubit = context.read<UpdateProfileCubit>();
        cubit.onUsernameUnfocused();
      }
    });

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        final cubit = context.read<UpdateProfileCubit>();
        cubit.onEmailUnfocused();
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        final cubit = context.read<UpdateProfileCubit>();
        cubit.onPasswordUnfocused();
      }
    });

    _passwordConfirmationFocusNode.addListener(() {
      if (!_passwordConfirmationFocusNode.hasFocus) {
        final cubit = context.read<UpdateProfileCubit>();
        cubit.onPasswordConfirmationUnfocused();
      }
    });

    _xUsernameFocusNode.addListener(() {
      if (!_xUsernameFocusNode.hasFocus) {
        final cubit = context.read<UpdateProfileCubit>();
        cubit.onXUsernameUnfocused();
      }
    });

    _fbUsernameFocusNode.addListener(() {
      if (!_fbUsernameFocusNode.hasFocus) {
        final cubit = context.read<UpdateProfileCubit>();
        cubit.onFacebookUsernameUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordConfirmationFocusNode.dispose();
    _xUsernameFocusNode.dispose();
    _fbUsernameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      listenWhen: (oldState, newState) =>
          (oldState is UpdateProfileLoaded
              ? oldState.submissionStatus
              : null) !=
          (newState is UpdateProfileLoaded ? newState.submissionStatus : null),
      listener: (context, state) {
        if (state is UpdateProfileLoaded) {
          if (state.submissionStatus == SubmissionStatus.success) {
            widget.onUpdateProfileSuccess();
          }

          if (state.submissionStatus == SubmissionStatus.error) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const GenericErrorSnackBar(),
              );
          }
        }
      },
      builder: (context, state) {
        final l10n = UpdateProfileLocalizations.of(context);
        if (state is UpdateProfileLoaded) {
          final usernameError =
              state.username.isNotValid ? state.username.error : null;
          final emailError = state.email.isNotValid ? state.email.error : null;
          final passwordError =
              state.password.isNotValid ? state.password.error : null;
          final passwordConfirmationError =
              state.passwordConfirmation.isNotValid
                  ? state.passwordConfirmation.error
                  : null;
          final xUsernameError =
              state.xUsername!.isNotValid ? state.xUsername!.error : null;
          final fbUsernameError = state.facebookUsername!.isNotValid
              ? state.facebookUsername!.error
              : null;
          final profanityFilter = state.profanityFilter;
          final isSubmissionInProgress =
              state.submissionStatus == SubmissionStatus.inProgress;
          final cubit = context.read<UpdateProfileCubit>();

          return Column(
            children: <Widget>[
              //Username
              TextFormField(
                focusNode: _usernameFocusNode,
                initialValue: state.username.value,
                onChanged: cubit.onUsernameChanged,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.person,
                  ),
                  enabled: !isSubmissionInProgress,
                  labelText: l10n.usernameTextFieldLabel,
                  errorText: usernameError == null
                      ? null
                      : (usernameError == UsernameValidationError.empty
                          ? l10n.usernameTextFieldEmptyErrorMessage
                          : (usernameError ==
                                  UsernameValidationError.isAlreadyTaken
                              ? l10n.usernameTextFieldAlreadyTakenErrorMessage
                              : l10n.usernameTextFieldInvalidErrorMessage)),
                ),
              ),
              const SizedBox(
                height: Spacing.mediumLarge,
              ),
              //email
              TextFormField(
                focusNode: _emailFocusNode,
                initialValue: state.email.value,
                onChanged: cubit.onEmailChanged,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.email,
                  ),
                  enabled: !isSubmissionInProgress,
                  labelText: l10n.emailTextFieldLabel,
                  errorText: emailError == null
                      ? null
                      : (emailError == EmailValidationError.empty
                          ? l10n.emailTextFieldEmptyErrorMessage
                          : (emailError ==
                                  EmailValidationError.alreadyRegistered
                              ? l10n.emailTextFieldAlreadyRegisteredErrorMessage
                              : l10n.emailTextFieldInvalidErrorMessage)),
                ),
              ),
              const SizedBox(
                height: Spacing.mediumLarge,
              ),
              //New Password
              TextFormField(
                focusNode: _passwordFocusNode,
                onChanged: cubit.onPasswordChanged,
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.password,
                    ),
                    enabled: !isSubmissionInProgress,
                    labelText: l10n.passwordTextFieldLabel,
                    errorText: passwordError == null
                        ? null
                        : l10n.passwordTextFieldInvalidErrorMessage),
              ),
              const SizedBox(
                height: Spacing.mediumLarge,
              ),
              //New Password Confirmation
              TextFormField(
                focusNode: _passwordConfirmationFocusNode,
                onChanged: cubit.onPasswordConfirmationChanged,
                onEditingComplete: cubit.onSubmit,
                obscureText: true,
                decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.password,
                    ),
                    enabled: !isSubmissionInProgress,
                    labelText: l10n.passwordConfirmationTextFieldLabel,
                    errorText: passwordConfirmationError == null
                        ? null
                        : l10n
                            .passwordConfirmationTextFieldInvalidErrorMessage),
              ),
              const SizedBox(
                height: Spacing.mediumLarge,
              ),
              //x_username
              TextFormField(
                focusNode: _xUsernameFocusNode,
                initialValue: state.xUsername?.value,
                onChanged: (value) => cubit.onXUsernameChanged,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                decoration: InputDecoration(
                  suffixIcon: SvgPicture.asset(
                    'assets/icons/twitter-x.svg',
                  ),
                  enabled: !state.isSubmissionInProgress,
                  labelText: l10n.xUsernameLabel,
                  errorText: xUsernameError == null
                      ? null
                      : (xUsernameError == XFaUsernameValidationError.empty
                          ? l10n.xUsernameTextFieldEmptyErrorMessage
                          : l10n.xUsernameTextFieldInvalidErrorMessage),
                ),
              ),
              const SizedBox(
                height: Spacing.mediumLarge,
              ),
              //facebook_username
              TextFormField(
                focusNode: _fbUsernameFocusNode,
                initialValue: state.facebookUsername?.value,
                onChanged: (value) => cubit.onFacebookUsernameChanged,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                decoration: InputDecoration(
                  suffixIcon: SvgPicture.asset(
                    'assets/icons/facebook.svg',
                    width: 24,
                    height: 24,
                  ),
                  enabled: !state.isSubmissionInProgress,
                  labelText: l10n.facebookUsernameLabel,
                  errorText: fbUsernameError == null
                      ? null
                      : (fbUsernameError == XFaUsernameValidationError.empty
                          ? l10n.xUsernameTextFieldEmptyErrorMessage
                          : l10n.xUsernameTextFieldInvalidErrorMessage),
                ),
              ),
              const SizedBox(
                height: Spacing.mediumLarge,
              ),
              //Pic
              CustomListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  size: 24,
                ),
                title: l10n.updateProfilePictureTileLabel,
                subtitle: l10n.updateProfilePictureSubtitleLabel,
                onTap: () => _showPicEditOptions(
                  context,
                  state,
                  l10n,
                ),
              ),
              const SizedBox(
                height: Spacing.mediumLarge,
              ),
              //Profanity Filter
              CustomListTile(
                title: l10n.profanityFilterTileLabel,
                subtitle: profanityFilter
                    ? l10n.disableProfanityFilterSubtitle
                    : l10n.enableProfanityFilterSubtitle,
                trailing: Switch(
                  value: profanityFilter,
                  onChanged: (value) => cubit.onProfanityFilterToggled(value),
                ),
                onTap: () => cubit.onProfanityFilterToggled(!profanityFilter),
              ),
              const SizedBox(
                height: Spacing.xxxLarge,
              ),
              isSubmissionInProgress
                  ? ExpandedElevatedButton.inProgress(
                      label: l10n.updateProfileButtonLabel,
                    )
                  : ExpandedElevatedButton(
                      onTap: cubit.onSubmit,
                      label: l10n.updateProfileButtonLabel,
                      icon: const Icon(
                        Icons.login,
                      ),
                    ),
            ],
          );
        } else {
          return const CenteredCircularProgressIndicator();
        }
      },
    );
  }

  void _showPicEditOptions(
    BuildContext context,
    UpdateProfileState state,
    UpdateProfileLocalizations l10n,
  ) {
    final cubit = context.read<UpdateProfileCubit>();
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
          buildShowModalBottomSheet(context, theme, l10n, state, cubit);
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
        cubit,
      );
    } else {
      showThemeError(context);
    }
  }

  Future<dynamic> buildShowModalBottomSheet(
    BuildContext context,
    ThemeData theme,
    UpdateProfileLocalizations l10n,
    UpdateProfileState state,
    UpdateProfileCubit cubit,
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
                    if (state is UpdateProfileLoaded) {
                      if (state.facebookUsername == null) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            CustomSnackBar(
                              content: l10n.emptyFacebookUsernameErrorMessage,
                            ) as SnackBar,
                          );
                      } else {
                        cubit.onPicUpdated(Pic.facebook);
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
                    if (state is UpdateProfileLoaded) {
                      if (state.xUsername == null) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            CustomSnackBar(
                              content: l10n.emptyXUsernameErrorMessage,
                            ) as SnackBar,
                          );
                      } else {
                        cubit.onPicUpdated(Pic.twitter);
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
                    if (state is UpdateProfileLoaded) {
                      if (state.email.value.isEmpty) {
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
                        cubit.onPicUpdated(Pic.gravater);
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
