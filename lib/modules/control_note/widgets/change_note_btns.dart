import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/models/note.dart';
import 'package:notewise/modules/control_note/bloc/control_note_bloc.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/ink_wrapper.dart';

class ChangeNoteBtns extends StatelessWidget {
  final GlobalKey<FormState> controlNoteKey;
  final String text;
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
        _buildBtn(context,
            title: 'Save',
            onTap: () => {
                  if (controlNoteKey.currentState!.validate())
                    context.read<ControlNoteBloc>().updateNote(
                          text: text,
                          id: noteModel.id,
                          userId: userId,
                          image: image,
                        ),
                }),
        _buildBtn(
          context,
          title: 'Delete',
          onTap: () => showDialog(
            context: context,
            builder: (dialogContext) =>
                _deleteNote(context, dialogContext: dialogContext),
          ),
        ),
      ],
    );
  }

  Widget _buildBtn(BuildContext context,
      {required String title, required Function() onTap}) {
    return InkWrapper(
      radius: 50,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                0.1,
                0.9,
              ],
              colors: [
                AppColors.secondaryColor,
                AppColors.primaryColor,
              ],
            )),
        child: Text(
          title,
          style: TextStyle(
            fontSize: Utils.adaptiveWidth(context, 7),
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            color: Colors.white,
          ),
        ),
      ),
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
