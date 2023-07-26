import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/utils.dart';

class ImageField extends StatelessWidget {
  final File? image;
  final String? url;
  const ImageField({
    this.image,
    this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return image != null || url != null
        ? SizedBox(
            height: Utils.adaptiveHeight(context, 45),
            width: Utils.adaptiveWidth(context, 100),
            child: image != null
                ? Image.file(
                    image!,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    imageUrl: url!,
                    fit: BoxFit.contain,
                  ),
          )
        : const SizedBox();
  }
}
