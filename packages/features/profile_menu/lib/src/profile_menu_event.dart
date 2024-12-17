part of 'profile_menu_bloc.dart';

abstract class ProfileMenuEvent extends Equatable {
  const ProfileMenuEvent();

  @override
  List<Object?> get props => [];
}

class ProfileMenuStarted extends ProfileMenuEvent {
  const ProfileMenuStarted();
}

class ProfileMenuIsEditingProfile extends ProfileMenuEvent {
  const ProfileMenuIsEditingProfile();
}

class ProfileMenuUsernameChanged extends ProfileMenuEvent {
  const ProfileMenuUsernameChanged(
    this.username,
  );

  final String username;

  @override
  List<Object?> get props => [
        username,
      ];
}

class ProfileMenuUsernameUnfocused extends ProfileMenuEvent {
  const ProfileMenuUsernameUnfocused();
}

class ProfileMenuEmailChanged extends ProfileMenuEvent {
  const ProfileMenuEmailChanged(
    this.email,
  );

  final String email;

  @override
  List<Object?> get props => [
        email,
      ];
}

class ProfileMenuEmailUnfocused extends ProfileMenuEvent {
  const ProfileMenuEmailUnfocused();
}

class ProfileMenuPasswordChanged extends ProfileMenuEvent {
  const ProfileMenuPasswordChanged(
    this.password,
  );

  final String password;

  @override
  List<Object?> get props => [
        password,
      ];
}

class ProfileMenuPasswordUnfocused extends ProfileMenuEvent {
  const ProfileMenuPasswordUnfocused();
}

class ProfileMenuPasswordConfirmationChanged extends ProfileMenuEvent {
  const ProfileMenuPasswordConfirmationChanged(
    this.passwordConfirmation,
  );

  final String passwordConfirmation;

  @override
  List<Object?> get props => [
        passwordConfirmation,
      ];
}

class ProfileMenuPasswordConfirmationUnfocused extends ProfileMenuEvent {
  const ProfileMenuPasswordConfirmationUnfocused();
}

class ProfileMenuXUsernameChanged extends ProfileMenuEvent {
  const ProfileMenuXUsernameChanged(
    this.xUsername,
  );

  final String xUsername;

  @override
  List<Object?> get props => [
        xUsername,
      ];
}

class ProfileMenuXUsernameUnfocused extends ProfileMenuEvent {
  const ProfileMenuXUsernameUnfocused();
}

class ProfileMenuFacebookUsernameChanged extends ProfileMenuEvent {
  const ProfileMenuFacebookUsernameChanged(
    this.facebookUsername,
  );

  final String facebookUsername;

  @override
  List<Object?> get props => [
        facebookUsername,
      ];
}

class ProfileMenuFacebookUsernameUnfocused extends ProfileMenuEvent {
  const ProfileMenuFacebookUsernameUnfocused();
}

class ProfileMenuUpdatePic extends ProfileMenuEvent {
  const ProfileMenuUpdatePic(this.pic);

  final Pic pic;

  @override
  List<Object?> get props => [
        pic,
      ];
}

class ProfileMenuProfanityFilterToggled extends ProfileMenuEvent {
  const ProfileMenuProfanityFilterToggled(this.profanityFilter);

  final bool profanityFilter;

  @override
  List<Object?> get props => [
        profanityFilter,
      ];
}

class ProfileMenuOnSubmit extends ProfileMenuEvent {
  const ProfileMenuOnSubmit();
}

class ProfileMenuSignedOut extends ProfileMenuEvent {
  const ProfileMenuSignedOut();
}
