import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/models/note.dart';
import 'package:notewise/modules/control_note/bloc/control_note_bloc.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/custom_button.dart';

class ChangeNoteBtns extends StatelessWidget {
  final GlobalKey<FormState> controlNoteKey;
  final TextEditingController text;
  final File? image;
  final String userId;
  final NoteModel noteModel;

  const ChangeNoteBtns({
    required this.controlNoteKey,
    required this.text,
    required this.image,
    required this.userId,
    required this.noteModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          text: 'Save',
          onTap: () => {
            if (controlNoteKey.currentState!.validate())
              context.read<ControlNoteBloc>().updateNote(
                    text: text.text,
                    id: noteModel.id,
                    userId: userId,
                    image: image,
                  ),
          },
        ),
        CustomButton(
          text: 'Delete',
          onTap: () => showDialog(
            context: context,
            builder: (dialogContext) =>
                _deleteNote(context, dialogContext: dialogContext),
          ),
        ),
      ],
    );
  }

  AlertDialog _deleteNote(BuildContext context,
      {required BuildContext dialogContext}) {
    return AlertDialog(
      title: const Text('Delete Note'),
      content: const Text('Are you sure you want to delete this note?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(
            'No',
            style: TextStyle(
              fontSize: Utils.adaptiveWidth(context, 5),
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: AppColors.textColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () => {
            Navigator.of(dialogContext).pop(true),
            context.read<ControlNoteBloc>().deleteNote(
                  note: noteModel,
                  userId: userId,
                ),
          },
          child: Text(
            'Yes',
            style: TextStyle(
              fontSize: Utils.adaptiveWidth(context, 5),
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: AppColors.errorColor,
            ),
          ),
        ),
      ],
      titleTextStyle: TextStyle(
        fontSize: Utils.adaptiveWidth(context, 7),
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: AppColors.textColor,
      ),
      contentTextStyle: TextStyle(
        fontSize: Utils.adaptiveWidth(context, 5),
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: AppColors.textColor.withOpacity(0.5),
      ),
    );
  }
}
