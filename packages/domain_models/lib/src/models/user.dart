import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.username,
    this.email,
  });

  final String? username;

  final String? email;

  @override
  List<Object?> get props => [
        username,
        email,
      ];
}
