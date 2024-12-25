part of 'update_profile_cubit.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object?> get props => [];
}

class UpdateProfileInProgress extends UpdateProfileState {
  const UpdateProfileInProgress();
}

class UpdateProfileLoaded extends UpdateProfileState {
  const UpdateProfileLoaded({
    required this.username,
    required this.email,
    this.password = const OptionalPassword.unvalidated(),
    this.passwordConfirmation =
        const OptionalPasswordConfirmation.unvalidated(),
    this.xUsername = const XFaUsername.unvalidated(),
    this.facebookUsername = const XFaUsername.unvalidated(),
    this.pic,
    this.profanityFilter = true,
    this.submissionStatus = SubmissionStatus.idle,
  });

  final Username username;
  final Email email;
  final OptionalPassword password;
  final OptionalPasswordConfirmation passwordConfirmation;
  final XFaUsername? xUsername;
  final XFaUsername? facebookUsername;
  final Pic? pic;
  final bool profanityFilter;
  final SubmissionStatus submissionStatus;

  bool get isSubmissionInProgress =>
      submissionStatus == SubmissionStatus.inProgress;

  UpdateProfileLoaded copyWith({
    Username? username,
    Email? email,
    OptionalPassword? password,
    OptionalPasswordConfirmation? passwordConfirmation,
    XFaUsername? xUsername,
    XFaUsername? facebookUsername,
    Pic? pic,
    bool? profanityFilter,
    SubmissionStatus? submissionStatus,
  }) {
    return UpdateProfileLoaded(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      xUsername: xUsername ?? this.xUsername,
      facebookUsername: facebookUsername ?? this.facebookUsername,
      pic: pic ?? this.pic,
      profanityFilter: profanityFilter ?? this.profanityFilter,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        username,
        email,
        password,
        passwordConfirmation,
        xUsername,
        facebookUsername,
        pic,
        profanityFilter,
        submissionStatus,
      ];
}

enum Pic {
  twitter,
  facebook,
  gravater,
}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  error,
}
