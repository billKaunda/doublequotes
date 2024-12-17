part of './profile_menu_screen.dart';

class ViewUpdateProfileMenu extends StatefulWidget {
  const ViewUpdateProfileMenu({
    super.key,
  });

  @override
  State<ViewUpdateProfileMenu> createState() => _ViewUpdateProfileMenuState();
}

class _ViewUpdateProfileMenuState extends State<ViewUpdateProfileMenu> {
  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordConfirmationFocusNode = FocusNode();
  final _xUsernameFocusNode = FocusNode();
  final _facebookUsernameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      if (!_usernameFocusNode.hasFocus) {
        final bloc = context.read<ProfileMenuBloc>();
        bloc.add(
          const ProfileMenuUsernameUnfocused(),
        );
      }
    });
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        final bloc = context.read<ProfileMenuBloc>();
        bloc.add(
          const ProfileMenuEmailUnfocused(),
        );
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        final bloc = context.read<ProfileMenuBloc>();
        bloc.add(
          const ProfileMenuPasswordUnfocused(),
        );
      }
    });
    _passwordConfirmationFocusNode.addListener(() {
      if (!_passwordConfirmationFocusNode.hasFocus) {
        final bloc = context.read<ProfileMenuBloc>();
        bloc.add(
          const ProfileMenuPasswordConfirmationUnfocused(),
        );
      }
    });
    _xUsernameFocusNode.addListener(() {
      if (!_xUsernameFocusNode.hasFocus) {
        final bloc = context.read<ProfileMenuBloc>();
        bloc.add(
          const ProfileMenuXUsernameUnfocused(),
        );
      }
    });
    _facebookUsernameFocusNode.addListener(() {
      if (!_facebookUsernameFocusNode.hasFocus) {
        final bloc = context.read<ProfileMenuBloc>();
        bloc.add(
          const ProfileMenuFacebookUsernameUnfocused(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileMenuBloc, ProfileMenuState>(
      listenWhen: (oldState, newState) =>
          (oldState is ProfileMenuLoaded ? oldState.submissionStatus : null) !=
          (newState is ProfileMenuLoaded ? newState.submissionStatus : null),
      listener: (context, state) {
        if (state is ProfileMenuLoaded) {
          if (state.submissionStatus == SubmissionStatus.success) {
            return;
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
        final l10n = ProfileMenuLocalizations.of(context);
        if (state is ProfileMenuLoaded) {
          final usernameError =
              state.username!.isNotValid ? state.username!.error : null;
          final emailError =
              state.email!.isNotValid ? state.email!.error : null;
          final passwordError =
              state.password!.isNotValid ? state.password!.error : null;
          final passwordConfirmationError =
              state.passwordConfirmation!.isNotValid
                  ? state.passwordConfirmation!.error
                  : null;
          final xUsernameError =
              state.xUsername!.isNotValid ? state.xUsername!.error : null;
          final facebookUsernameError = state.facebookUsername!.isNotValid
              ? state.facebookUsername!.error
              : null;
          final isSubmissionInProgress =
              state.submissionStatus == SubmissionStatus.inProgress;
          final bloc = context.read<ProfileMenuBloc>();
          final isEditingProfile = state.isEditingProfile;
          final profanityFilter = state.profanityFilter;

          return Column(
            children: [
              //Username
              buildEditableWidget(
                isEditingProfile: isEditingProfile,
                editWidget: TextFormField(
                  focusNode: _usernameFocusNode,
                  initialValue: state.username!.value,
                  onChanged: (username) => bloc.add(
                    ProfileMenuUsernameChanged(
                      username,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.person,
                    ),
                    enabled: !isSubmissionInProgress,
                    labelText: l10n.usernameLabel,
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
                viewWidget: CustomListTile(
                  leading: const Icon(Icons.person_2),
                  title: l10n.usernameLabel,
                  titleFontSize: FontSize.small,
                  subtitle: state.username!.value,
                  subtitleFontSize: FontSize.mediumLarge,
                  trailing: IconButton(
                    onPressed: () => bloc.add(
                      const ProfileMenuIsEditingProfile(),
                    ),
                    icon: const Icon(Icons.edit),
                  ),
                  dense: false,
                ),
              ),
              const Divider(),
              const SizedBox(height: Spacing.large),
              //Email
              buildEditableWidget(
                isEditingProfile: isEditingProfile,
                editWidget: TextFormField(
                  focusNode: _emailFocusNode,
                  initialValue: state.email!.value,
                  onChanged: (value) => bloc.add(
                    ProfileMenuEmailChanged(value),
                  ),
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.email,
                    ),
                    enabled: !state.isSubmissionInProgress,
                    labelText: l10n.emailLabel,
                    errorText: emailError == null
                        ? null
                        : (emailError == EmailValidationError.empty
                            ? l10n.emailTextFieldEmptyErrorMessage
                            : (emailError ==
                                    EmailValidationError.alreadyRegistered
                                ? l10n
                                    .emailTextFieldAlreadyRegisteredErrorMessage
                                : l10n.emailTextFieldInvalidErrorMessage)),
                  ),
                ),
                viewWidget: CustomListTile(
                  leading: const Icon(Icons.mark_email_read),
                  title: l10n.emailLabel,
                  titleFontSize: FontSize.small,
                  subtitle: state.email!.value,
                  subtitleFontSize: FontSize.mediumLarge,
                  trailing: IconButton(
                    onPressed: () => bloc.add(
                      const ProfileMenuIsEditingProfile(),
                    ),
                    icon: const Icon(Icons.edit),
                  ),
                  dense: false,
                ),
              ),
              const Divider(),
              const SizedBox(height: Spacing.large),
              //TODO see how you can obscure the password & password
              //Password
              CustomExpansionTile(
                title: l10n.updatePasswordTileLabel,
                children: [
                  Builder(
                    builder: (context) {
                      return Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            //Password
                            TextFormField(
                              focusNode: _passwordFocusNode,
                              onChanged: (password) => bloc.add(
                                ProfileMenuPasswordChanged(password),
                              ),
                              textInputAction: TextInputAction.next,
                              obscureText: true,
                              decoration: InputDecoration(
                                  suffixIcon: const Icon(
                                    Icons.password,
                                  ),
                                  enabled: !isSubmissionInProgress,
                                  labelText: l10n.passwordLabel,
                                  errorText: passwordError == null
                                      ? null
                                      : l10n
                                          .passwordTextFieldInvalidErrorMessage),
                            ),
                            const SizedBox(
                              height: Spacing.mediumLarge,
                            ),
                            //Password confirmation
                            TextFormField(
                              focusNode: _passwordConfirmationFocusNode,
                              onChanged: (password) => bloc.add(
                                ProfileMenuPasswordConfirmationChanged(
                                  password,
                                ),
                              ),
                              onEditingComplete: () {
                                bloc.add(const ProfileMenuOnSubmit());

                                ExpansionTileController.of(context).collapse();
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  suffixIcon: const Icon(
                                    Icons.password,
                                  ),
                                  enabled: !isSubmissionInProgress,
                                  labelText: l10n.passwordConfirmationLabel,
                                  errorText: passwordConfirmationError == null
                                      ? null
                                      : l10n
                                          .passwordConfirmationTextFieldInvalidErrorMessage),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: Spacing.large),
              //x_username
              buildEditableWidget(
                isEditingProfile: isEditingProfile,
                editWidget: TextFormField(
                  focusNode: _xUsernameFocusNode,
                  initialValue: state.xUsername!.value,
                  onChanged: (value) => bloc.add(
                    ProfileMenuXUsernameChanged(value),
                  ),
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
                viewWidget: CustomListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/twitter-x.svg',
                    width: 24,
                    height: 24,
                  ),
                  title: l10n.xUsernameLabel,
                  titleFontSize: FontSize.small,
                  subtitle: state.xUsername!.value,
                  subtitleFontSize: FontSize.mediumLarge,
                  trailing: IconButton(
                    onPressed: () => bloc.add(
                      const ProfileMenuIsEditingProfile(),
                    ),
                    icon: const Icon(Icons.edit),
                  ),
                  dense: false,
                ),
              ),
              const Divider(),
              const SizedBox(height: Spacing.large),
              //facebook_username
              buildEditableWidget(
                isEditingProfile: isEditingProfile,
                editWidget: TextFormField(
                  focusNode: _facebookUsernameFocusNode,
                  initialValue: state.facebookUsername!.value,
                  onChanged: (value) => bloc.add(
                    ProfileMenuFacebookUsernameChanged(value),
                  ),
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
                    errorText: facebookUsernameError == null
                        ? null
                        : (facebookUsernameError ==
                                XFaUsernameValidationError.empty
                            ? l10n.xUsernameTextFieldEmptyErrorMessage
                            : l10n.xUsernameTextFieldInvalidErrorMessage),
                  ),
                ),
                viewWidget: CustomListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/facebook.svg',
                  ),
                  title: l10n.facebookUsernameLabel,
                  titleFontSize: FontSize.small,
                  subtitle: state.facebookUsername!.value,
                  subtitleFontSize: FontSize.mediumLarge,
                  trailing: IconButton(
                    onPressed: () => bloc.add(
                      const ProfileMenuIsEditingProfile(),
                    ),
                    icon: const Icon(Icons.edit),
                  ),
                  dense: false,
                ),
              ),
              const Divider(),
              const SizedBox(height: Spacing.large),
              //Profanity_filter
              CustomListTile(
                title: l10n.profanityFilterTileLabel,
                subtitle: profanityFilter
                    ? l10n.disableProfanityFilterSubtitle
                    : l10n.enableProfanityFilterSubtitle,
                trailing: Switch(
                  value: profanityFilter,
                  onChanged: (value) => bloc.add(
                    ProfileMenuProfanityFilterToggled(value),
                  ),
                ),
                onTap: () => bloc.add(
                  ProfileMenuProfanityFilterToggled(!profanityFilter),
                ),
              ),
              const Divider(),
              const SizedBox(height: Spacing.xxxLarge),
              isSubmissionInProgress
                  ? ExpandedElevatedButton.inProgress(
                      label: l10n.updateProfileButtonLabel,
                    )
                  : ExpandedElevatedButton(
                      onTap: () => bloc.add(const ProfileMenuOnSubmit()),
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

  Widget buildEditableWidget({
    required bool isEditingProfile,
    required Widget editWidget,
    required Widget viewWidget,
  }) {
    return isEditingProfile
        ? Padding(
            padding: const EdgeInsets.only(
              left: Spacing.mediumLarge,
              right: Spacing.mediumLarge,
              top: Spacing.mediumLarge,
            ),
            child: editWidget,
          )
        : viewWidget;
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordConfirmationFocusNode.dispose();
    _xUsernameFocusNode.dispose();
    _facebookUsernameFocusNode.dispose();
    super.dispose();
  }
}
