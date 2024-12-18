import 'package:equatable/equatable.dart';

class UpdateUser extends Equatable {
  const UpdateUser({
    this.username,
    this.email,
    this.password,
    this.twitterUsername,
    this.facebookUsername,
    this.pic,
    this.enableProfanityFilter,
  });

  final String? username;
  final String? email;
  final String? password;
  final String? twitterUsername;
  final String? facebookUsername;
  final String? pic;
  final bool? enableProfanityFilter;

  @override
  List<Object?> get props => [
        username,
        email,
        password,
        twitterUsername,
        facebookUsername,
        pic,
        enableProfanityFilter,
      ];
}
