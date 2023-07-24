import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final String id;
  final String text;
  final String? image;

  const NoteModel({
    required this.id,
    required this.text,
    this.image,
  });

  factory NoteModel.fromMap(Map<String, dynamic> json, String id) {
    return NoteModel(
      id: id,
      text: json['text'] as String,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'image': image,
    };
  }

  @override
  List<Object?> get props => [id, text, image];
}
