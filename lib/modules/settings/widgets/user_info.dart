import 'package:flutter/material.dart';
import 'package:notewise/core/models/user.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';

class UserInfo extends StatelessWidget {
  final UserModel user;
  const UserInfo({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Utils.adaptiveHeight(context, 2)),
      child: Row(
        children: [
          const Icon(Icons.person_2_outlined, color: Colors.black, size: 30),
          SizedBox(width: Utils.adaptiveWidth(context, 5)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText(context, user.name),
              const SizedBox(height: 5),
              _buildText(context, user.email, size: 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context, String text, {double size = 5}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: Utils.adaptiveWidth(context, size),
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: AppColors.textColor,
      ),
    );
  }
}
