import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/ink_wrapper.dart';

class AddImageBtn extends StatefulWidget {
  final ValueChanged<File?> image;
  final bool imageExist;
  const AddImageBtn({
    required this.image,
    this.imageExist = false,
    super.key,
  });

  @override
  State<AddImageBtn> createState() => _AddImageBtnState();
}

class _AddImageBtnState extends State<AddImageBtn> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return InkWrapper(
      onTap: _addImage,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.imageExist
              ? const Icon(Icons.change_circle_outlined)
              : const Icon(Icons.add_box_outlined),
          const SizedBox(width: 5),
          Text(
            widget.imageExist ? 'Change image' : 'Add Image',
            style: TextStyle(
              fontSize: Utils.adaptiveWidth(context, 4),
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addImage() async {
    if (Platform.isIOS) {
      await _iosModalPopup();
    } else {
      await _androidModalPopup();
    }
  }

  _androidModalPopup() async {
    return showModalBottomSheet(
      backgroundColor: AppColors.background,
      context: context,
      builder: (context) => ListView(
        children: [
          ListTile(
            leading: const Icon(
              Icons.camera_alt_rounded,
              color: AppColors.textColor,
            ),
            title: Text(
              'Camera',
              style: TextStyle(
                fontSize: Utils.adaptiveWidth(context, 5),
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: AppColors.textColor,
              ),
            ),
            onTap: () => _onAndroidOpenCamera(),
          ),
          ListTile(
            leading: const Icon(
              Icons.photo_album_rounded,
              color: AppColors.textColor,
            ),
            title: Text(
              'Gallery',
              style: TextStyle(
                fontSize: Utils.adaptiveWidth(context, 5),
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: AppColors.textColor,
              ),
            ),
            onTap: () => _onAndroidOpenGallery(),
          ),
        ],
      ),
    );
  }

  Future<void> _iosModalPopup() async {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              'Camera',
              style: TextStyle(
                fontSize: Utils.adaptiveWidth(context, 5),
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: AppColors.textColor,
              ),
            ),
            onPressed: () => _onIosOpenCamera(),
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Gallery',
              style: TextStyle(
                fontSize: Utils.adaptiveWidth(context, 5),
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: AppColors.textColor,
              ),
            ),
            onPressed: () => _onIosOpenGallery(),
          ),
        ],
      ),
    );
  }

  void _onAndroidOpenCamera() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      widget.image(File(pickedImage.path));
    }
    if (mounted) return;
    Navigator.pop(context);
  }

  void _onAndroidOpenGallery() async {
    Navigator.pop(context);
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      widget.image(File(pickedImage.path));
    }
    if (mounted) return;
    Navigator.pop(context);
  }

  void _onIosOpenCamera() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      widget.image(File(pickedImage.path));
    }
    if (mounted) return;
    Navigator.pop(context);
  }

  void _onIosOpenGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      widget.image(File(pickedImage.path));
    }
    if (mounted) return;
    Navigator.pop(context);
  }
}
