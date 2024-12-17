part of 'profile_menu_bloc.dart';

abstract class ProfileMenuState extends Equatable {
  const ProfileMenuState();

  @override
  List<Object?> get props => [];
}

class ProfileMenuInProgress extends ProfileMenuState {
  const ProfileMenuInProgress();
}

class ProfileMenuLoaded extends ProfileMenuState {
  const ProfileMenuLoaded({
    this.isSignOutInProgress = false,
    this.isUserAuthenticated = false,
    this.isEditingProfile = false,
    this.username,
    this.picUrl,
    this.publicFavoritesCount,
    this.followers,
    this.following,
    this.isProUser = false,
    this.accountDetails,
    this.email,
    this.password = const OptionalPassword.unvalidated(),
    this.passwordConfirmation =
        const OptionalPasswordConfirmation.unvalidated(),
    this.xUsername = const XFaUsername.unvalidated(),
    this.facebookUsername = const XFaUsername.unvalidated(),
    this.pic,
    this.profanityFilter = true,
    this.submissionStatus = SubmissionStatus.idle,
  });

  final bool isSignOutInProgress;
  final bool isUserAuthenticated;
  final bool isEditingProfile;
  final Username? username;
  final String? picUrl;
  final int? publicFavoritesCount;
  final int? followers;
  final int? following;
  final bool isProUser;
  final AccountDetails? accountDetails;
  final Email? email;
  final OptionalPassword? password;
  final OptionalPasswordConfirmation? passwordConfirmation;
  final XFaUsername? xUsername;
  final XFaUsername? facebookUsername;
  final Pic? pic;
  final bool profanityFilter;
  final SubmissionStatus? submissionStatus;

  bool get isSubmissionInProgress =>
      submissionStatus == SubmissionStatus.inProgress;

  ProfileMenuLoaded copyWith({
    bool? isSignOutInProgress,
    bool? isUserAuthenticated,
    bool? isEditingProfile,
    Username? username,
    String? picUrl,
    int? publicFavoritesCount,
    int? followers,
    int? following,
    bool? isProUser,
    AccountDetails? accountDetails,
    Email? email,
    OptionalPassword? password,
    OptionalPasswordConfirmation? passwordConfirmation,
    XFaUsername? xUsername,
    XFaUsername? facebookUsername,
    Pic? pic,
    bool? profanityFilter,
    SubmissionStatus? submissionStatus,
  }) {
    return ProfileMenuLoaded(
      isSignOutInProgress: isSignOutInProgress ?? this.isSignOutInProgress,
      isUserAuthenticated: isUserAuthenticated ?? this.isUserAuthenticated,
      isEditingProfile: isEditingProfile ?? this.isEditingProfile,
      username: username ?? this.username,
      picUrl: picUrl ?? this.picUrl,
      publicFavoritesCount: publicFavoritesCount ?? this.publicFavoritesCount,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isProUser: isProUser ?? this.isProUser,
      accountDetails: accountDetails ?? this.accountDetails,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      xUsername: xUsername ?? this.xUsername,
      facebookUsername: facebookUsername ?? this.facebookUsername,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      pic: pic ?? this.pic,
      profanityFilter: profanityFilter ?? this.profanityFilter,
    );
  }

  @override
  List<Object?> get props => [
        isSignOutInProgress,
        isUserAuthenticated,
        isEditingProfile,
        username,
        picUrl,
        publicFavoritesCount,
        followers,
        following,
        isProUser,
        accountDetails,
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

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  error,
}

enum Pic {
  twitter,
  facebook,
  gravater,
}
