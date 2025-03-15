class User {
  final String id;
  final String email;
  final String name;

  User({required this.id, required this.email, required this.name});

  // Convert User object to a Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'name': name};
  }

  // Create User object from a Map (from Firestore)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id'], email: map['email'], name: map['name']);
  }
}
