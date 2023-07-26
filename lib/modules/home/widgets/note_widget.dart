import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notewise/core/models/note.dart';
import 'package:notewise/core/models/user.dart';
import 'package:notewise/modules/control_note/control_note_screen.dart';
import 'package:notewise/modules/home/bloc/home_bloc.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/ink_wrapper.dart';

class NoteWidget extends StatelessWidget {
  final NoteModel note;
  final UserModel user;
  final VoidCallback onUpdate;
  const NoteWidget(
      {required this.note,
      required this.user,
      required this.onUpdate,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(note.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return await showDialog(
            context: context,
            builder: (dialogContext) =>
                _deleteNote(context, dialogContext: dialogContext),
          );
        }
        return false;
      },
      child: InkWrapper(
        onTap: () => _onChangeNote(context),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.secondaryColor,
                AppColors.primaryColor,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
                image: note.image != null
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(note.image ?? ''),
                        fit: BoxFit.cover,
                        opacity: 1.0,
                      )
                    : null,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: note.image != null
                      ? AppColors.textColor.withOpacity(0.5)
                      : AppColors.background,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Utils.adaptiveHeight(context, 2)),
                  child: Column(
                    children: [
                      _buildDate(context, note.lastUpdate),
                      SizedBox(height: Utils.adaptiveHeight(context, 3)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Utils.adaptiveWidth(context, 5)),
                        child: _buildText(context, note.text),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
            context.read<HomeBloc>().deleteNote(note: note, user: user),
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

  Widget _buildDate(BuildContext context, Timestamp timeStamp) {
    final date = timeStamp.toDate();
    final String timeFormat =
        DateFormat('dd/MM/yyyy - HH:mm:ss').format(date).toString();
    return Text(
      timeFormat,
      style: TextStyle(
        fontSize: Utils.adaptiveWidth(context, 7),
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: note.image != null ? Colors.white : AppColors.textColor,
      ),
    );
  }

  Widget _buildText(BuildContext context, String text) {
    return Text(
      text,
      overflow: TextOverflow.fade,
      style: TextStyle(
        fontSize: Utils.adaptiveWidth(context, 5),
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: note.image != null ? Colors.white : AppColors.textColor,
      ),
    );
  }

  Future<void> _onChangeNote(BuildContext context) async {
    final ControlNoteArgs args = ControlNoteArgs(
      note: note,
      user: user,
    );
    final result = await Navigator.pushNamed(
      context,
      ControlNoteScreen.routeName,
      arguments: args,
    );
    if (result is bool && result) {
      onUpdate.call();
    }
  }
}
