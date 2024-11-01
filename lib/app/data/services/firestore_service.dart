import "package:cloud_firestore/cloud_firestore.dart";

import "../firebase/user/user_payload.dart";
import "../repository/base_model.dart";

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<T> getCollection<T extends BaseModel>(
      String path, T Function(Map<String, dynamic>) fromJson) {
    return FirebaseFirestore.instance.collection(path).withConverter<T>(
          fromFirestore: (snapshot, _) => fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }
}
