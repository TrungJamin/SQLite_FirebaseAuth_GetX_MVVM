class User {
  final int id;
  final String username;
  final String password;
  User({this.id, this.username, this.password});

  Map<String, dynamic> toMap() {
    // toJson
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  // Implement toString to make it easier to see information about
  // each user when using the print statement.
  @override
  String toString() {
    return 'User{id: $id, name: $username, password: $password}';
  }
}
