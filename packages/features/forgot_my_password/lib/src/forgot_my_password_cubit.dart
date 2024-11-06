import 'package:user_repository/user_repository.dart';
import 'package:form_fields/form_fields.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_my_password_state.dart';

class ForgotMyPasswordCubit extends Cubit<ForgotMyPasswordState> {
  ForgotMyPasswordCubit({
    required this.userRepository,
  }) : super(
          const ForgotMyPasswordState(),
        );

  final UserRepository userRepository;

  void onEmailChanged(String newEmail) {
    final previousEmailValue = state.email;
    final shouldValidate = previousEmailValue.isNotValid;
    final newEmailState = state.copyWith(
        email: shouldValidate
            ? Email.validated(
                newEmail,
                isAlreadyRegistered: newEmail == previousEmailValue.value
                    ? previousEmailValue.isAlreadyRegistered
                    : false,
              )
            : Email.unvalidated(
                newEmail,
              ));

    emit(newEmailState);
  }

  void onEmailUnfocused() {
    final newState = state.copyWith(
      email: Email.validated(
        state.email.value,
      ),
    );
    emit(newState);
  }

  void onSubmit() async {
    final email = Email.validated(state.email.value);
    final newState = state.copyWith(
      email: email,
      submissionStatus: email.isValid ? SubmissionStatus.inProgress : null,
    );

    emit(newState);

    if (email.isValid) {
      try {
        await userRepository.remoteUsersApi.forgotPasswordRequest(
          email.value,
        );

        final newState =
            state.copyWith(submissionStatus: SubmissionStatus.success);

        emit(newState);
      } catch (_) {
        final newState =
            state.copyWith(submissionStatus: SubmissionStatus.error);
        emit(newState);
      }
    }
  }
}
