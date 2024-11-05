import "package:menyusha/app/data/firebase/menu/menu_payload.dart";
import "package:menyusha/app/data/firebase/user/user_payload.dart";

import "../repository/firestore_repository.dart";

class MenuPayloadRepository extends FirestoreRepository<MenuPayload> {
  MenuPayloadRepository() : super("menu_payload", MenuPayload.fromJson);

  // Method to get all items by a specific user ID
  Future<List<MenuPayload>> getItemsByUserId(String userId) async {
    try {
      final snapshot =
          await collection.where('userId', isEqualTo: userId).get();

      return snapshot.docs
          .map((doc) => doc.data()!.copyWithId(id: doc.id) as MenuPayload)
          .toList();
    } catch (e) {
      print("Error getting items by user ID: $e");
      return [];
    }
  }

  // Method to get a live stream of items filtered by user ID
  Stream<List<MenuPayload>> getItemsLiveByUserId(String userId) {
    return collection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data()!.copyWithId(id: doc.id) as MenuPayload)
          .toList();
    });
  }

  // Function to create a new MenuPayload
  Future<MenuPayload?> createMenu(MenuPayload payload) async =>
      createItem(payload);

  Future<MenuPayload?> updateMenu(MenuPayload payload) async =>
      updateItem(payload);

  Future<void> deleteMenu(MenuPayload payload) async => deleteItem(payload.id);

  // Method to get a single item by publicId
  Future<MenuPayload?> getItemByPublicId(String publicId) async {
    try {
      final snapshot = await collection
          .where('publicId', isEqualTo: publicId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        return doc.data()!.copyWithId(id: doc.id) as MenuPayload;
      } else {
        print("No item found with publicId: $publicId");
        return null;
      }
    } catch (e) {
      print("Error getting item by publicId: $e");
      return null;
    }
  }
}
