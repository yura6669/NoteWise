import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/modules/control_note/bloc/control_note_bloc.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/ink_wrapper.dart';

class AddNoteBtn extends StatelessWidget {
  final GlobalKey<FormState> controlNoteKey;
  final TextEditingController text;
  final Alignment alignment;
  final File? image;
  final String userId;
  const AddNoteBtn({
    required this.controlNoteKey,
    required this.text,
    required this.image,
    required this.userId,
    this.alignment = Alignment.center,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: InkWrapper(
        radius: 50,
        onTap: () {
          if (controlNoteKey.currentState!.validate()) {
            context.read<ControlNoteBloc>().addNote(
                  userId: userId,
                  text: text.text,
                  image: image,
                );
          }
        },
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
            'Add Note',
            style: TextStyle(
              fontSize: Utils.adaptiveWidth(context, 7),
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
