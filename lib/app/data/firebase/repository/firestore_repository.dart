import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import "../services/firestore_service.dart";
import "base_model.dart";

class FirestoreRepository<T extends BaseModel> {
  FirestoreRepository(final String collectionPath,
      final T Function(Map<String, dynamic>) fromJson) {
    collection = service.getCollection<T>(collectionPath, fromJson);
  }

  final GetIt getIt = GetIt.instance;

  late final FirestoreService service = getIt.get<FirestoreService>();
  late final CollectionReference<T> collection;

  Future<T?> createItem(final T item) async {
    try {
      final docRef = await collection.add(item);
      final tempItem = await getItem(docRef.id);
      await updateItem(tempItem!);
      return tempItem;
    } catch (e) {
      print("Error creating item: $e");
      return null;
    }
  }

  // Read an item by ID
  Future<T?> getItem(final String id) async {
    try {
      final snapshot = await collection.doc(id).get();

      if (snapshot.exists) {
        final snap = snapshot.data()!;
        return snap.copyWithId(id: snapshot.id) as T;
      }
    } catch (e) {
      print("Error getting item: $e");
      return null;
    }
    return null;
  }

  // Read all items
  Future<List<T>> getItems() async {
    try {
      final snapshot = await collection.get();

      return snapshot.docs
          .map((final doc) => doc.data()!.copyWithId(id: doc.id) as T)
          .toList();
    } catch (e) {
      print("Error getting items: $e");
      return [];
    }
  }

  // Update an item
  Future<T?> updateItem(final T item) async {
    try {
      final r = await collection.doc(item.id);

      await r.set(item);
      await getItem(r.id);
    } catch (e) {
      print("Error updating item: $e ${item.toJson()}");
    }
  }

  // Delete an item
  Future<void> deleteItem(final String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting item: $e");
    }
  }

  // Get a live stream of items
  Stream<List<T>> getItemsLive() {
    return collection.snapshots().map((final snapshot) {
      return snapshot.docs
          .map((final doc) => doc.data()!.copyWithId(id: doc.id) as T)
          .toList();
    });
  }
}
