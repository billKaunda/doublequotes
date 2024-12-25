import 'package:domain_models/domain_models.dart';
import 'package:user_repository/user_repository.dart';
import 'package:form_fields/form_fields.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit({
    required this.userRepository,
  }) : super(
          const UpdateProfileInProgress(),
        ) {
    _fetchUserCredentials();
  }

  final UserRepository userRepository;

  void onUsernameChanged(String newUsername) {
    final currentState = state as UpdateProfileLoaded;
    final previousUsername = currentState.username;
    final shouldValidate = previousUsername.isNotValid;

    final newState = currentState.copyWith(
      username: shouldValidate
          ? Username.validated(newUsername,
              isAlreadyRegistered: newUsername == previousUsername.value
                  ? previousUsername.isAlreadyRegistered
                  : false)
          : Username.unvalidated(newUsername),
    );

    emit(newState);
  }

  void onUsernameUnfocused() {
    final currentState = state as UpdateProfileLoaded;
    final newState = currentState.copyWith(
      username: Username.validated(
        currentState.username.value,
        isAlreadyRegistered: currentState.username.isAlreadyRegistered,
      ),
    );
    emit(newState);
  }

  void onEmailChanged(String newEmail) {
    final currentState = state as UpdateProfileLoaded;
    final previousEmail = currentState.email;
    final shouldValidate = previousEmail.isNotValid;

    final newEmailState = currentState.copyWith(
      email: shouldValidate
          ? Email.validated(
              newEmail,
              isAlreadyRegistered: newEmail == previousEmail.value
                  ? previousEmail.isAlreadyRegistered
                  : false,
            )
          : Email.unvalidated(newEmail),
    );

    emit(newEmailState);
  }

  void onEmailUnfocused() {
    final currentState = state as UpdateProfileLoaded;
    final newState = currentState.copyWith(
      email: Email.validated(
        currentState.email.value,
        isAlreadyRegistered: currentState.email.isAlreadyRegistered,
      ),
    );

    emit(newState);
  }

  void onPasswordChanged(String newPassword) {
    final currentState = state as UpdateProfileLoaded;
    final previousPassword = currentState.password;
    final shouldValidate = previousPassword.isNotValid;

    final newState = currentState.copyWith(
      password: shouldValidate
          ? OptionalPassword.validated(newPassword)
          : OptionalPassword.unvalidated(newPassword),
    );
    emit(newState);
  }

  void onPasswordUnfocused() {
    final currentState = state as UpdateProfileLoaded;
    final newState = currentState.copyWith(
      password: OptionalPassword.validated(
        currentState.password.value,
      ),
    );
    emit(newState);
  }

  void onPasswordConfirmationChanged(newPassConf) {
    final currentState = state as UpdateProfileLoaded;
    final previousPasswordConfirmation = currentState.passwordConfirmation;
    final shouldValidate = previousPasswordConfirmation.isNotValid;

    final newState = currentState.copyWith(
      passwordConfirmation: shouldValidate
          ? OptionalPasswordConfirmation.validated(
              newPassConf,
              password: currentState.password,
            )
          : OptionalPasswordConfirmation.unvalidated(newPassConf),
    );

    emit(newState);
  }

  void onPasswordConfirmationUnfocused() {
    final currentState = state as UpdateProfileLoaded;
    final newState = currentState.copyWith(
      passwordConfirmation: OptionalPasswordConfirmation.validated(
        currentState.passwordConfirmation.value,
        password: currentState.password,
      ),
    );
    emit(newState);
  }

  void onXUsernameChanged(String newXUsername) {
    final currentState = state as UpdateProfileLoaded;
    final previousXUsername = currentState.xUsername;
    final shouldValidate = previousXUsername!.isNotValid;

    final newState = currentState.copyWith(
      xUsername: shouldValidate
          ? XFaUsername.validated(newXUsername)
          : XFaUsername.unvalidated(newXUsername),
    );
    emit(newState);
  }

  void onXUsernameUnfocused() {
    final currentState = state as UpdateProfileLoaded;
    final newState = currentState.copyWith(
      xUsername: XFaUsername.validated(
        currentState.xUsername!.value,
      ),
    );

    emit(newState);
  }

  void onFacebookUsernameChanged(String newFbUsername) {
    final currentState = state as UpdateProfileLoaded;
    final previousFbUsername = currentState.facebookUsername;
    final shouldValidate = previousFbUsername!.isNotValid;

    final newState = currentState.copyWith(
      facebookUsername: shouldValidate
          ? XFaUsername.validated(newFbUsername)
          : XFaUsername.unvalidated(newFbUsername),
    );
    emit(newState);
  }

  void onFacebookUsernameUnfocused() {
    final currentState = state as UpdateProfileLoaded;
    final newState = currentState.copyWith(
      facebookUsername: XFaUsername.validated(
        currentState.facebookUsername!.value,
      ),
    );

    emit(newState);
  }

  void onPicUpdated(Pic pic) async {
    final currentState = state as UpdateProfileLoaded;
    final previousPic = currentState.pic;

    if (previousPic != pic) {
      emit(
        currentState.copyWith(pic: pic),
      );
    }
  }

  void onProfanityFilterToggled(bool profanityFilter) async {
    final currentState = state as UpdateProfileLoaded;
    final previousProfanityFilterValue = currentState.profanityFilter;

    if (previousProfanityFilterValue != profanityFilter) {
      emit(
        currentState.copyWith(profanityFilter: profanityFilter),
      );
    }
  }

  void onSubmit() async {
    final currentState = state as UpdateProfileLoaded;
    final username = Username.validated(
      currentState.username.value,
      isAlreadyRegistered: currentState.username.isAlreadyRegistered,
    );
    final email = Email.validated(
      currentState.email.value,
      isAlreadyRegistered: currentState.email.isAlreadyRegistered,
    );
    final password = OptionalPassword.validated(currentState.password.value);
    final passwordConfirmation = OptionalPasswordConfirmation.validated(
      currentState.passwordConfirmation.value,
      password: currentState.password,
    );
    final xUsername = XFaUsername.validated(currentState.xUsername!.value);
    final facebookUsername =
        XFaUsername.validated(currentState.facebookUsername!.value);
    final pic = currentState.pic;
    final profanityFilter = currentState.profanityFilter;

    final isFormValid = Formz.validate([
      username,
      email,
      password,
      passwordConfirmation,
      xUsername,
      facebookUsername,
    ]);

    final newState = currentState.copyWith(
      username: username,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      xUsername: xUsername,
      facebookUsername: facebookUsername,
      pic: pic,
      profanityFilter: profanityFilter,
      submissionStatus: isFormValid ? SubmissionStatus.inProgress : null,
    );

    emit(newState);

    if (isFormValid) {
      try {
        await userRepository.updateUser(
          username: username.value,
          email: email.value,
          newPassword: password.value,
          twitterUsername: xUsername.value,
          facebookUsername: facebookUsername.value,
          pic: pic!.name,
          enableProfanityFilter: profanityFilter,
        );

        final newState = currentState.copyWith(
          submissionStatus: SubmissionStatus.success,
        );

        emit(newState);
      } catch (error) {
        final newState = currentState.copyWith(
          submissionStatus: error is UsernameAlreadyTaken &&
                  error is EmailAlreadyRegistered &&
                  error is PicNotFound &&
                  error is ProfanityFilterToggleError
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
        emit(newState);
      }
    }
  }

  Future<void> _fetchUserCredentials() async {
    final userCredentials = await userRepository.createUserSession().first;
    if (userCredentials != null) {
      final newState = UpdateProfileLoaded(
        username: Username.unvalidated(userCredentials.username),
        email: Email.unvalidated(userCredentials.email),
      );

      emit(newState);
    }
  }
}
