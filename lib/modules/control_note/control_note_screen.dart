import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/di/locator.dart';
import 'package:notewise/core/models/note.dart';
import 'package:notewise/core/models/user.dart';
import 'package:notewise/modules/control_note/bloc/control_note_bloc.dart';
import 'package:notewise/modules/control_note/widgets/add_image_btn.dart';
import 'package:notewise/modules/control_note/widgets/change_note_btns.dart';
import 'package:notewise/modules/control_note/widgets/control_note_app_bar.dart';
import 'package:notewise/modules/control_note/widgets/control_note_form.dart';
import 'package:notewise/modules/control_note/widgets/image_field.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/custom_button.dart';
import 'package:notewise/modules/widgets/custom_snack_bar.dart';

class ControlNoteArgs {
  final NoteModel? note;
  final UserModel user;

  ControlNoteArgs({
    this.note,
    required this.user,
  });
}

class ControlNoteScreen extends StatefulWidget {
  static const String routeName = 'control-note';
  final ControlNoteArgs args;
  const ControlNoteScreen({required this.args, super.key});

  @override
  State<ControlNoteScreen> createState() => _ControlNoteScreenState();
}

class _ControlNoteScreenState extends State<ControlNoteScreen> {
  late GlobalKey<FormState> _controlNoteKey;
  late TextEditingController _text;
  late File? _image;
  late ControlNoteBloc _controlNoteBloc;

  @override
  void initState() {
    _controlNoteKey = GlobalKey<FormState>();
    _text = TextEditingController();
    _text.text = widget.args.note != null ? widget.args.note!.text : '';
    _image = null;
    _controlNoteBloc = locator.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _controlNoteBloc,
      child: BlocListener<ControlNoteBloc, ControlNoteState>(
        listener: _listener,
        child: BlocBuilder<ControlNoteBloc, ControlNoteState>(
          builder: (context, state) {
            return Stack(
              children: [
                _buildContent(state),
                if (state.isLoading) _buildLoader(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return Scaffold(
      backgroundColor: AppColors.textColor.withOpacity(0.5),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildContent(ControlNoteState state) {
    return Scaffold(
      appBar: controNotelAppBAr(
        context: context,
        title: widget.args.note != null ? 'Change note' : 'Add Note',
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: Utils.adaptiveHeight(context, 5),
            left: Utils.adaptiveWidth(context, 5),
            right: Utils.adaptiveWidth(context, 5),
            bottom: Utils.adaptiveHeight(context, 2),
          ),
          child: Column(
            children: [
              ControlNoteForm(
                controlNoteKey: _controlNoteKey,
                text: _text,
              ),
              SizedBox(height: Utils.adaptiveHeight(context, 3)),
              AddImageBtn(
                image: (value) {
                  setState(() {
                    _image = value;
                  });
                },
                imageExist: _image != null || widget.args.note?.image != null,
              ),
              const Spacer(),
              ImageField(
                image: _image,
                url: widget.args.note?.image,
              ),
              const Spacer(),
              if (widget.args.note == null)
                CustomButton(
                  text: 'Add note',
                  onTap: () {
                    if (_controlNoteKey.currentState!.validate()) {
                      _controlNoteBloc.addNote(
                        userId: widget.args.user.id,
                        text: _text.text,
                        image: _image,
                      );
                    }
                  },
                ),
              if (widget.args.note != null)
                ChangeNoteBtns(
                  controlNoteKey: _controlNoteKey,
                  text: _text,
                  image: _image,
                  userId: widget.args.user.id,
                  noteModel: widget.args.note!,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, ControlNoteState state) {
    if (state.isSuccessAddNote) {
      showSnackbar(context, text: 'You add new note', color: AppColors.success);
      Navigator.pop(context, true);
    } else if (state.isSuccessUpdateNote) {
      showSnackbar(context, text: 'You update note', color: AppColors.success);
      Navigator.pop(context, true);
    } else if (state.isSuccessDeleteNote) {
      showSnackbar(context, text: 'You delete note', color: AppColors.success);
      Navigator.pop(context, true);
    } else if (state.isNoInternet) {
      showSnackbar(context,
          text: 'No internet connection', color: AppColors.errorColor);
    } else if (state.isError) {
      showSnackbar(context,
          text: 'Something went wrong', color: AppColors.errorColor);
    }
  }
}
