import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:notewise/core/models/note.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/ink_wrapper.dart';

class NoteWidget extends StatelessWidget {
  final NoteModel note;
  const NoteWidget(this.note, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(note.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return await showDialog(
            context: context,
            builder: (context) => _deleteNote(context),
          );
        }
        return false;
      },
      child: InkWrapper(
        onTap: () {},
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
                      _buildDate(context, note.id),
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

  AlertDialog _deleteNote(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Note'),
      content: const Text('Are you sure you want to delete this note?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
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
          onPressed: () => Navigator.of(context).pop(true),
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

  Widget _buildDate(BuildContext context, String id) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(id));
    final String timeFormat =
        '${date.year}/${date.month}/${date.day} ${date.hour}:${date.minute}:${date.second}';
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
}
