import 'package:flutter/material.dart';
import 'package:notewise/core/models/user.dart';
import 'package:notewise/modules/control_note/control_note_screen.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';

homeAppBar({
  required BuildContext context,
  required String greeting,
  required String name,
  required UserModel user,
  required VoidCallback onUpdate,
}) {
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    automaticallyImplyLeading: false,
    centerTitle: true,
    elevation: 0,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            AppColors.secondaryColor,
            AppColors.primaryColor,
          ],
        ),
      ),
    ),
    title: FittedBox(
      child: Text(
        '$greeting, $name',
        style: TextStyle(
          fontSize: Utils.adaptiveWidth(context, 7),
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          color: AppColors.textColor,
        ),
      ),
    ),
    leading: IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.settings_outlined,
        size: Utils.adaptiveWidth(context, 7),
        color: AppColors.textColor,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () => _onChangeNote(
          context: context,
          user: user,
          onUpdate: onUpdate,
        ),
        icon: Icon(
          Icons.note_add_outlined,
          size: Utils.adaptiveWidth(context, 7),
          color: AppColors.textColor,
        ),
      ),
    ],
  );
}

Future<void> _onChangeNote(
    {required BuildContext context,
    required UserModel user,
    required VoidCallback onUpdate}) async {
  final ControlNoteArgs args = ControlNoteArgs(
    note: null,
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
