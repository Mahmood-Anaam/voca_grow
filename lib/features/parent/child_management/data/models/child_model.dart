class Child {
  final String id;
  final String name;
  final int age;
  final String gender;

  Child({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
  });

  // Convert Child object to a Map (for Firebase)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
    };
  }

  // Create Child object from a Map (from Firebase)
  factory Child.fromMap(Map<String, dynamic> map) {
    return Child(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      gender: map['gender'],
    );
  }
}