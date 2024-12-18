import 'package:equatable/equatable.dart';

class UserCredentials extends Equatable {
  const UserCredentials({
    required this.username,
    required this.email,
  });

  final String? username;

  final String? email;

  @override
  List<Object?> get props => [
        username,
        email,
      ];
}
