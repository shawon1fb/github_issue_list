import 'package:flutter/material.dart';

import 'cache_image.dart';

class ContactProfileImage extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double size;

  const ContactProfileImage({
    required this.imageUrl,
    required this.name,
    this.size = 50,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CacheImageView(
      image: imageUrl,
      placeholderFadeInDuration: 20,
      errorChild: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF315362),
        ),
        child: Center(
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : '',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: SizedBox(width: size, height: size),
    );
  }
}
