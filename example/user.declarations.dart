import 'macros/data_class.dart';
import 'macros/json.dart';

@dataClass
@jsonSerializable
class User {
  @jsonSerializable
  external Map<String, Object?> toJson();
  @jsonSerializable
  external User.fromJson(Map<String, Object?> json);
  User({
    required this.name,
  });
  User copyWith({String? name}) => User(name: name ?? this.name);
  @override
  int get hashCode => name.hashCode;
  @override
  bool operator ==(Object other) => other is User && this.name == other.name;
  @override
  String toString() => '${User} {name: ${name}}';
  String name;
}

@dataClass
@jsonSerializable
class Group {
  @jsonSerializable
  external Map<String, Object?> toJson();
  @jsonSerializable
  external Group.fromJson(Map<String, Object?> json);
  Group({
    required this.name,
    required this.users,
  });
  Group copyWith({String? name, List<User>? users}) =>
      Group(name: name ?? this.name, users: users ?? this.users);
  @override
  int get hashCode => name.hashCode ^ users.hashCode;
  @override
  bool operator ==(Object other) =>
      other is Group && this.name == other.name && this.users == other.users;
  @override
  String toString() => '${Group} {name: ${name}, users: ${users}}';
  final String name;
  final List<User> users;
}

@jsonSerializable
class Manager extends User {
  @jsonSerializable
  external Map<String, Object?> toJson();
  @jsonSerializable
  external Manager.fromJson(Map<String, Object?> json);
  final List<User> reports;
  Manager({required String name, required this.reports}) : super(name: name);
}
