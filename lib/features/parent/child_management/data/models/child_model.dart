enum Gender { male, female }
enum Activity { speechTherapy, reading, singing }

class ChildModel {
  final String id;
  final String name;
  final Gender gender;
  final DateTime birthDate;
  final List<Activity> availableActivities;
  final String email;
  final String password;

  ChildModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthDate,
    required this.availableActivities,
    required this.email,
    required this.password,
  });

  // Método de cópia para facilitar atualizações imutáveis
  ChildModel copyWith({
    String? id,
    String? name,
    Gender? gender,
    DateTime? birthDate,
    List<Activity>? availableActivities,
    String? email,
    String? password,
  }) {
    return ChildModel(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      availableActivities: availableActivities ?? this.availableActivities,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}