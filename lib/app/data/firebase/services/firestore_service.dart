import "package:cloud_firestore/cloud_firestore.dart";

import "../repository/base_model.dart";

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<T> getCollection<T extends BaseModel>(
          final String path, final T Function(Map<String, dynamic>) fromJson) =>
      _firestore.collection(path).withConverter<T>(
            fromFirestore: (final snapshot, final _) =>
                fromJson(snapshot.data()!),
            toFirestore: (final model, final _) => model.toJson(),
          );
}
