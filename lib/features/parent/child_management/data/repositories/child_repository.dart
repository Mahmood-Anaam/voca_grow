import '../models/child_model.dart';

class ChildRepository {
  // Simular uma lista de dados como se fosse de uma API
  final List<ChildModel> _children = [
    ChildModel(
      id: '1',
      name: 'Ahmed',
      gender: Gender.male,
      birthDate: DateTime(2018, 5, 15),
      availableActivities: [Activity.speechTherapy, Activity.reading],
      email: 'ahmed@vocagrow.com',
      password: 'child123',
    ),
    ChildModel(
      id: '2',
      name: 'Fatima',
      gender: Gender.female,
      birthDate: DateTime(2019, 8, 20),
      availableActivities: [Activity.singing, Activity.reading],
      email: 'fatima@vocagrow.com',
      password: 'child456',
    ),
  ];

  // Simular busca de dados
  Future<List<ChildModel>> fetchChildren() async {
    // Simular delay de rede
    await Future.delayed(const Duration(milliseconds: 500));
    return _children;
  }

  // Simular adição de criança
  Future<ChildModel> addChild(ChildModel child) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _children.add(child);
    return child;
  }

  // Simular atualização de criança
  Future<ChildModel> updateChild(ChildModel child) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _children.indexWhere((c) => c.id == child.id);
    if (index != -1) {
      _children[index] = child;
    }
    return child;
  }

  // Simular remoção de criança
  Future<void> deleteChild(String childId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _children.removeWhere((child) => child.id == childId);
  }
}
