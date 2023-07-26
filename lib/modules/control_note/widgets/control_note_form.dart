import 'package:flutter/material.dart';
import 'package:notewise/modules/widgets/field.dart';

class ControlNoteForm extends StatefulWidget {
  final GlobalKey<FormState> controlNoteKey;
  final TextEditingController text;
  const ControlNoteForm(
      {required this.controlNoteKey, required this.text, super.key});

  @override
  State<ControlNoteForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<ControlNoteForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controlNoteKey,
      child: Field(
        controller: widget.text,
        labelText: 'Write something',
        hintText: 'Write your note',
        validator: (value) => _textValidator(value),
        prefixIcon: const Icon(
          Icons.notes_rounded,
          color: Colors.black,
        ),
        maxLines: 5,
      ),
    );
  }

  String? _textValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your note';
    }
    return null;
  }
}
