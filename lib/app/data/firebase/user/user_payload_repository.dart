import "package:menyusha/app/data/firebase/user/user_payload.dart";
import "package:menyusha/app/data/repository/firestore_repository.dart";

class UserPayloadRepository extends FirestoreRepository<UserPayload> {
  UserPayloadRepository() : super("payloads", UserPayload.fromJson);

  // Create
  Future<UserPayload?> createUser(final String uid) async {
    try {
      final newPayload = UserPayload(
        id: "",
        uid: uid,
      );

      final createdPayload = await createItem(newPayload);
      return createdPayload;
    } catch (e) {
      print("Error creating user: $e");
      return null;
    }
  }

  // Read
  Future<UserPayload?> getUserByUID(final String uid) async {
    try {
      final querySnapshot =
          await collection.where("uid", isEqualTo: uid).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        final userDoc = querySnapshot.docs.first;
        return userDoc.data();
      } else {
        return null;
      }
    } catch (e) {
      print("Error finding user by UID: $e");
      return null;
    }
  }

  Future<UserPayload?> findOrCreateUserPayloadByUID(final String uid) async {
    final existingUser = await getUserByUID(uid);
    return existingUser ?? await createUser(uid);
  }

  // Update
  Future<UserPayload?> updateUser(final UserPayload user) async {
    try {
      await updateItem(user);
      print("User updated successfully");
      return user;
    } catch (e) {
      print("Error updating user: $e");
      return null;
    }
  }

  // Delete
  Future<void> deleteUser(final String id) async {
    try {
      await deleteItem(id);
      print("User deleted successfully");
    } catch (e) {
      print("Error deleting user: $e");
    }
  }
}
