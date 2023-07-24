import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notewise/core/models/note.dart';

class NotesRepository implements INotesRepository {
  @override
  Future<List<NoteModel>> getNotes(String userId) async {
    final CollectionReference collection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notes');
    final data = await collection.get();
    final mapped = data.docs.map((e) {
      final map = e.data() as Map<String, dynamic>?;
      if (map != null) {
        return NoteModel.fromMap(map, e.id);
      }
    });
    final List<NoteModel> notes = [];
    final result = mapped.toList();
    if (result.isNotEmpty) {
      for (var note in result) {
        if (note != null) {
          notes.add(note);
        }
      }
    }
    return notes;
  }
}

abstract class INotesRepository {
  Future<List<NoteModel>> getNotes(String userId);
}
