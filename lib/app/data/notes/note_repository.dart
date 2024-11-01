import "package:menyusha/app/data/notes/note.dart";
import "package:menyusha/app/data/repository/firestore_repository.dart";

class NoteRepository extends FirestoreRepository<Note> {
  NoteRepository() : super("notes", Note.fromJson);

  Future<Note?> createNewEmptyItem(final content) async {
    final item = Note(
        content: content, id: null, creationDate: DateTime.now(), userId: "");
    return createItem(item);
  }
}
