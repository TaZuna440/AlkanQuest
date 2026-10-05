import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/image_picker_helper.dart';

class ChallengeIcon extends StatelessWidget {
  final String? iconPath;
  final Color color;
  final double size;

  const ChallengeIcon({
    super.key,
    required this.iconPath,
    required this.color,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    if (iconPath == null) return _placeholder();

    return FutureBuilder<String>(
      future: ImagePickerHelper.resolveAbsolute(iconPath!),
      builder: (context, snap) {
        if (!snap.hasData) return _placeholder();
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 8,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.file(
              File(snap.data!),
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _placeholder(),
            ),
          ),
        );
      },
    );
  }

  Widget _placeholder() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color, width: 2),
      ),
      child: Icon(
        Icons.savings_outlined,
        color: color,
        size: size * 0.5,
      ),
    );
  }
}
