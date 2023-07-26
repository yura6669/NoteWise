import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final String id;
  final String text;
  final String? image;
  final Timestamp lastUpdate;

  const NoteModel({
    required this.id,
    required this.text,
    this.image,
    required this.lastUpdate,
  });

  factory NoteModel.fromMap(Map<String, dynamic> json, String id) {
    return NoteModel(
      id: id,
      text: json['text'] as String,
      image: json['image'] as String?,
      lastUpdate: json['last_update'] as Timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      if (image != null) 'image': image,
      'last_update': lastUpdate,
    };
  }

  @override
  List<Object?> get props => [id, text, image];
}
