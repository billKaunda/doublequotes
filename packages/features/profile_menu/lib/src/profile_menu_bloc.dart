import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain_models/domain_models.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:activity_repository/activity_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:form_fields/form_fields.dart';

part 'profile_menu_state.dart';

part 'profile_menu_event.dart';

class ProfileMenuBloc extends Bloc<ProfileMenuEvent, ProfileMenuState> {
  ProfileMenuBloc({
    required this.userRepository,
    required this.quoteRepository,
    required this.activityRepository,
  }) : super(
          const ProfileMenuInProgress(),
        ) {
    _registerEventHandler();
  }
  final UserRepository userRepository;
  final QuoteRepository quoteRepository;
  final ActivityRepository activityRepository;

  void _registerEventHandler() {
    on<ProfileMenuEvent>(
      (event, emitter) async {
        switch (event) {
          case ProfileMenuStarted():
            await _handleProfileMenuStarted(emitter);
            break;
          case ProfileMenuIsEditingProfile():
            await _handleProfileMenuIsEditingProfile(emitter);
            break;
          case ProfileMenuUsernameChanged():
            await _handleProfileMenuUsernameChanged(emitter, event);
            break;
          case ProfileMenuUsernameUnfocused():
            await _handleProfileMenuUsernameUnfocused(emitter);
            break;
          case ProfileMenuEmailChanged():
            await _handleProfileMenuEmailChanged(emitter, event);
            break;
          case ProfileMenuEmailUnfocused():
            await _handleProfileMenuEmailUnfocused(emitter);
            break;
          case ProfileMenuPasswordChanged():
            await _handleProfileMenuPasswordChanged(emitter, event);
            break;
          case ProfileMenuPasswordUnfocused():
            await _handleProfileMenuPasswordUnfocused(emitter);
            break;
          case ProfileMenuPasswordConfirmationChanged():
            await _handleProfileMenuPasswordConfirmationChanged(emitter, event);
            break;
          case ProfileMenuPasswordConfirmationUnfocused():
            await _handleProfileMenuPasswordConfirmationUnfocused(emitter);
            break;
          case ProfileMenuXUsernameChanged():
            await _handleProfileMenuXUsernameChanged(emitter, event);
            break;
          case ProfileMenuXUsernameUnfocused():
            await _handleProfileMenuXUsernameUnfocused(emitter);
            break;
          case ProfileMenuFacebookUsernameChanged():
            await _handleProfileMenuFacebookUsernameChanged(emitter, event);
            break;
          case ProfileMenuFacebookUsernameUnfocused():
            await _handleProfileMenuFacebookUsernameUnfocused(emitter);
            break;
          case ProfileMenuUpdatePic():
            await _handleProfileMenuUpdatePic(emitter, event);
            break;
          case ProfileMenuProfanityFilterToggled():
            await _handleProfileMenuProfanityFilterToggled(emitter, event);
            break;
          case ProfileMenuOnSubmit():
            await _handleProfileMenuOnSubmit(emitter, event);
            break;
          case ProfileMenuSignedOut():
            await _handleProfileMenuSignedOut(emitter, event);
            break;
          default:
            throw UnsupportedError(
                'Unsupported event type: ${event.runtimeType}');
        }
        //transformer argument of the on() function gives you the ability
        // to customize your events. Overriding the transformer argument
        // is the factor you should consider when deciding to pick Blocs
        // over Cubits for a specific screen.
      },
      transformer: (events, mapper) => events.flatMap(
        mapper,
      ),
    );
  }

  Future<void> _handleProfileMenuStarted(Emitter emitter) async {
    await emitter.onEach(
      Rx.combineLatest3<UserCredentials?, User?, void, ProfileMenuLoaded>(
        userRepository.createUserSession(),
        userRepository.getUser(),
        userRepository.updateUser().asStream(),
        (userCred, user, updateUser) => ProfileMenuLoaded(
          username: Username.unvalidated(userCred!.username!),
          picUrl: user!.picUrl,
          publicFavoritesCount: user.publicFavoritesCount,
          followers: user.followers,
          following: user.following,
          isProUser: user.isProUser ?? false,
          accountDetails: user.accountDetails,
          email: Email.unvalidated(userCred.email!),
          password: const OptionalPassword.unvalidated(''),
          xUsername: const XFaUsername.unvalidated(''),
          facebookUsername: const XFaUsername.unvalidated(''),
          pic: null,
          profanityFilter: true,
        ),
      ),
      onData: emitter.call,
    );
  }

  Future<void> _handleProfileMenuIsEditingProfile(
    Emitter emitter,
  ) async {
    final currentState = state as ProfileMenuLoaded;

    emitter(
      currentState.copyWith(
        isEditingProfile: true,
      ),
    );
  }

  Future<void> _handleProfileMenuUsernameChanged(
    Emitter<ProfileMenuState> emitter,
    ProfileMenuUsernameChanged event,
  ) async {
    final currentState = state as ProfileMenuLoaded;
    final previousUsername = currentState.username;
    final shouldValidate = previousUsername!.isNotValid;
    final newUsername = event.username;

    final updatedUsername = shouldValidate
        ? Username.validated(
            newUsername,
            isAlreadyRegistered: newUsername == previousUsername.value
                ? previousUsername.isAlreadyRegistered
                : false,
          )
        : Username.unvalidated(newUsername);

    emitter(
      currentState.copyWith(
        username: updatedUsername,
      ),
    );
  }

  Future<void> _handleProfileMenuUsernameUnfocused(
    Emitter<ProfileMenuState> emitter,
  ) async {
    final currentState = state as ProfileMenuLoaded;
    final newState = currentState.copyWith(
      username: Username.validated(
        currentState.username!.value,
        isAlreadyRegistered: currentState.username!.isAlreadyRegistered,
      ),
    );

    emitter(newState);
  }

  Future<void> _handleProfileMenuEmailChanged(
    Emitter<ProfileMenuState> emitter,
    ProfileMenuEmailChanged event,
  ) async {
    final currentState = state as ProfileMenuLoaded;
    final previousEmail = currentState.email;
    final shouldValidate = previousEmail!.isNotValid;
    final newEmail = event.email;

    final updatedEmail = shouldValidate
        ? Email.validated(
            newEmail,
            isAlreadyRegistered: newEmail == previousEmail.value
                ? previousEmail.isAlreadyRegistered
                : false,
          )
        : Email.unvalidated(newEmail);

    emitter(
      currentState.copyWith(email: updatedEmail),
    );
  }

  Future<void> _handleProfileMenuEmailUnfocused(
    Emitter<ProfileMenuState> emitter,
  ) async {
    final currentState = state as ProfileMenuLoaded;

    emitter(
      currentState.copyWith(
        email: Email.validated(
          currentState.email!.value,
          isAlreadyRegistered: currentState.email!.isAlreadyRegistered,
        ),
      ),
    );
  }

  Future<void> _handleProfileMenuPasswordChanged(
    Emitter<ProfileMenuState> emitter,
    ProfileMenuPasswordChanged event,
  ) async {
    final currentState = state as ProfileMenuLoaded;
    final previousPassword = currentState.password;
    final shouldValidate = previousPassword!.isNotValid;
    final newPassword = event.password;

    final updatedPassword = shouldValidate
        ? OptionalPassword.validated(newPassword)
        : OptionalPassword.unvalidated(newPassword);

    emitter(
      currentState.copyWith(password: updatedPassword),
    );
  }

  Future<void> _handleProfileMenuPasswordUnfocused(
    Emitter<ProfileMenuState> emitter,
  ) async {
    final currentState = state as ProfileMenuLoaded;

    emitter(
      currentState.copyWith(
        password: OptionalPassword.validated(
          currentState.password!.value,
        ),
      ),
    );
  }

  Future<void> _handleProfileMenuPasswordConfirmationChanged(
    Emitter<ProfileMenuState> emitter,
    ProfileMenuPasswordConfirmationChanged event,
  ) async {
    final currentState = state as ProfileMenuLoaded;
    final previousPasswordConf = currentState.passwordConfirmation;
    final shouldValidate = previousPasswordConf!.isNotValid;
    final newPassConf = event.passwordConfirmation;

    final updatedPassConf = shouldValidate
        ? OptionalPasswordConfirmation.validated(
            newPassConf,
            password: currentState.password,
          )
        : OptionalPasswordConfirmation.unvalidated(newPassConf);

    emitter(
      currentState.copyWith(
        passwordConfirmation: updatedPassConf,
      ),
    );
  }

  Future<void> _handleProfileMenuPasswordConfirmationUnfocused(
    Emitter<ProfileMenuState> emitter,
  ) async {
    final currentState = state as ProfileMenuLoaded;

    emitter(
      currentState.copyWith(
        passwordConfirmation: OptionalPasswordConfirmation.validated(
          currentState.passwordConfirmation!.value,
          password: currentState.password,
        ),
      ),
    );
  }

  Future<void> _handleProfileMenuXUsernameChanged(
    Emitter<ProfileMenuState> emitter,
    ProfileMenuXUsernameChanged event,
  ) async {
    final currentState = state as ProfileMenuLoaded;
    final previousXUsername = currentState.xUsername;
    final shouldValidate = previousXUsername!.isNotValid;
    final newXUsername = event.xUsername;

    final updatedXUsername = shouldValidate
        ? XFaUsername.validated(
            newXUsername,
          )
        : XFaUsername.unvalidated(newXUsername);

    emitter(
      currentState.copyWith(xUsername: updatedXUsername),
    );
  }

  Future<void> _handleProfileMenuXUsernameUnfocused(
    Emitter<ProfileMenuState> emitter,
  ) async {
    final currentState = state as ProfileMenuLoaded;

    emitter(
      currentState.copyWith(
        xUsername: XFaUsername.validated(
          currentState.xUsername!.value,
        ),
      ),
    );
  }

  Future<void> _handleProfileMenuFacebookUsernameChanged(
    Emitter<ProfileMenuState> emitter,
    ProfileMenuFacebookUsernameChanged event,
  ) async {
    final currentState = state as ProfileMenuLoaded;
    final previousFbUsername = currentState.facebookUsername;
    final shouldValidate = previousFbUsername!.isNotValid;
    final newFbUsername = event.facebookUsername;

    final updatedFbUsername = shouldValidate
        ? XFaUsername.validated(
            newFbUsername,
          )
        : XFaUsername.unvalidated(newFbUsername);

    emitter(
      currentState.copyWith(xUsername: updatedFbUsername),
    );
  }

  Future<void> _handleProfileMenuFacebookUsernameUnfocused(
    Emitter<ProfileMenuState> emitter,
  ) async {
    final currentState = state as ProfileMenuLoaded;

    emitter(
      currentState.copyWith(
        facebookUsername: XFaUsername.validated(
          currentState.facebookUsername!.value,
        ),
      ),
    );
  }

  Future<void> _handleProfileMenuUpdatePic(
    Emitter<ProfileMenuState> emitter,
    ProfileMenuUpdatePic event,
  ) async {
    final currentState = state as ProfileMenuLoaded;
    final pic = event.pic.name;

    if (pic == 'twitter' && currentState.xUsername != null) {
      await userRepository.updateUser(
        twitterUsername: currentState.xUsername!.value,
        pic: pic,
      );
    } else if (pic == 'facebook' && currentState.facebookUsername != null) {
      await userRepository.updateUser(
        facebookUsername: currentState.facebookUsername!.value,
        pic: pic,
      );
    } else if (pic == 'gravater' && currentState.email != null) {
      await userRepository.updateUser(
        email: currentState.email!.value,
        pic: pic,
      );
    }

    add(
      const ProfileMenuStarted(),
    );
  }

  Future<void> _handleProfileMenuProfanityFilterToggled(
    Emitter<ProfileMenuState> emitter,
    ProfileMenuProfanityFilterToggled event,
  ) async {
    await userRepository.updateUser(
      enableProfanityFilter: event.profanityFilter,
    );

    add(
      const ProfileMenuStarted(),
    );
  }

  Future<void> _handleProfileMenuOnSubmit(
    Emitter<ProfileMenuState> emitter,
    ProfileMenuOnSubmit event,
  ) async {
    final currentState = state as ProfileMenuLoaded;
    final username = Username.validated(
      currentState.username!.value,
      isAlreadyRegistered: currentState.username!.isAlreadyRegistered,
    );
    final email = Email.validated(
      currentState.email!.value,
      isAlreadyRegistered: currentState.email!.isAlreadyRegistered,
    );
    final password = OptionalPassword.validated(
      currentState.password!.value,
    );
    final passwordConfirmation = OptionalPasswordConfirmation.validated(
      currentState.passwordConfirmation!.value,
      password: password,
    );
    final xUsername = XFaUsername.validated(
      currentState.xUsername!.value,
    );
    final facebookUsername = XFaUsername.validated(
      currentState.facebookUsername!.value,
    );
    final profanityFilter = currentState.profanityFilter;

    final isFormValid = Formz.validate([
      username,
      email,
      password,
      passwordConfirmation,
      xUsername,
      facebookUsername,
    ]);

    emitter(
      currentState.copyWith(
        username: username,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        xUsername: xUsername,
        facebookUsername: facebookUsername,
        profanityFilter: profanityFilter,
        submissionStatus: isFormValid ? SubmissionStatus.inProgress : null,
      ),
    );

    if (isFormValid) {
      try {
        await userRepository.updateUser(
          username: username.value,
          email: email.value,
          newPassword: password.value,
          twitterUsername: xUsername.value,
          facebookUsername: facebookUsername.value,
          enableProfanityFilter: profanityFilter,
        );

        emitter(currentState.copyWith(
          submissionStatus: SubmissionStatus.success,
        ));
      } catch (error) {
        final newState = currentState.copyWith(
          submissionStatus:
              error is! UsernameAlreadyTaken && error is! EmailAlreadyRegistered
                  ? SubmissionStatus.error
                  : SubmissionStatus.idle,
          username: error is UsernameAlreadyTaken
              ? Username.validated(
                  username.value,
                  isAlreadyRegistered: true,
                )
              : null,
          email: error is EmailAlreadyRegistered
              ? Email.validated(
                  email.value,
                  isAlreadyRegistered: true,
                )
              : null,
        );

        emitter(newState);
      }
    }
  }

  Future<void> _handleProfileMenuSignedOut(
    Emitter<ProfileMenuState> emitter,
    ProfileMenuSignedOut event,
  ) async {
    if (state is ProfileMenuLoaded) {
      final currentState = state as ProfileMenuLoaded;

      emitter(
        currentState.copyWith(isSignOutInProgress: true),
      );

      await userRepository.signOut();
      await quoteRepository.clearCache();
      await activityRepository.clearCache();
    }
  }
}
