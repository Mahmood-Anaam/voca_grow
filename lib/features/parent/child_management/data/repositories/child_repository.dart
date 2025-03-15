import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/child_model.dart';

class ChildRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new child
  Future<void> addChild(Child child, String parentId) async {
    await _firestore
        .collection('parents')
        .doc(parentId)
        .collection('children')
        .doc(child.id)
        .set(child.toMap());
  }

  // Get list of children for a parent
  Future<List<Child>> getChildren(String parentId) async {
    final snapshot =
        await _firestore
            .collection('parents')
            .doc(parentId)
            .collection('children')
            .get();
    return snapshot.docs.map((doc) => Child.fromMap(doc.data())).toList();
  }

  // Update child information
  Future<void> updateChild(Child child, String parentId) async {
    await _firestore
        .collection('parents')
        .doc(parentId)
        .collection('children')
        .doc(child.id)
        .update(child.toMap());
  }

  // Delete a child
  Future<void> deleteChild(String childId, String parentId) async {
    await _firestore
        .collection('parents')
        .doc(parentId)
        .collection('children')
        .doc(childId)
        .delete();
  }
}
