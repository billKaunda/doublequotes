part of 'sign_up_cubit.dart';

enum SubmissionStatus { idle, inProgress, success, error }

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.unvalidated(),
    this.username = const Username.unvalidated(),
    this.password = const Password.unvalidated(),
    this.passwordConfirmation = const PasswordConfirmation.unvalidated(),
    this.submissionStatus = SubmissionStatus.idle,
  });

  final Email? email;
  final Username? username;
  final Password? password;
  final PasswordConfirmation? passwordConfirmation;
  final SubmissionStatus? submissionStatus;

  SignUpState copyWith({
    Email? email,
    Username? username,
    Password? password,
    PasswordConfirmation? passwordConfirmation,
    SubmissionStatus? submissionStatus,
    bool? togglePasswordVisibility,
  }) {
    return SignUpState(
      email: email ?? this.email,
      username: username ?? this.username,
      password: togglePasswordVisibility != null
          ? (this.password?.copyWith(
                togglePasswordVisibility: togglePasswordVisibility,
              ))
          : password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        email,
        username,
        password,
        passwordConfirmation,
        submissionStatus,
      ];
}
