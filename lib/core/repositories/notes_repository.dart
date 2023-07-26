import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  @override
  Future<String> photoUrlWithStorage({
    required File photoFile,
    required String userId,
  }) async {
    var storage = FirebaseStorage.instance;
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    var snapshot =
        await storage.ref().child('users/$userId-$time').putFile(photoFile);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Future<void> addNote({
    required String userId,
    required String text,
    required String? image,
  }) {
    final CollectionReference collection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notes');
    final NoteModel note = NoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      image: image,
      lastUpdate: Timestamp.now(),
    );

    return collection.doc(note.id).set(note.toMap());
  }

  @override
  Future<void> updateNote({
    required String text,
    String? image,
    required String id,
    required String userId,
  }) {
    final CollectionReference collection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notes');
    final NoteModel note = NoteModel(
      id: id,
      text: text,
      image: image,
      lastUpdate: Timestamp.now(),
    );

    return collection.doc(note.id).update(note.toMap());
  }

  @override
  Future<void> deleteNote({required String id, required String userId}) {
    final CollectionReference collection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notes');
    return collection.doc(id).delete();
  }

  @override
  Future<void> deletePhotoWithStorage(String url) async {
    await FirebaseStorage.instance.refFromURL(url).delete();
  }
}

abstract class INotesRepository {
  Future<List<NoteModel>> getNotes(String userId);

  Future<String> photoUrlWithStorage({
    required File photoFile,
    required String userId,
  });

  Future<void> addNote({
    required String userId,
    required String text,
    required String? image,
  });

  Future<void> updateNote({
    required String text,
    String? image,
    required String id,
    required String userId,
  });

  Future<void> deleteNote({
    required String id,
    required String userId,
  });

  Future<void> deletePhotoWithStorage(String url);
}
