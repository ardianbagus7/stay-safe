part of 'models.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String role;
  final String profilePicture;

  User(this.id, this.email,
      {this.name,
      this.role,this.profilePicture});

  User copyWith({String name, String profilePicture}) =>
      User(
        this.id,
        this.email,
        name: name ?? this.name,
        role: role ?? this.role,
        profilePicture: profilePicture ?? '',
      );

  @override
  String toString() {
    return "[$id] - $name, $email";
  }

  @override
  List<Object> get props => [
        id,
        email,
        name,
        role,
      ];
}
