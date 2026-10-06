import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../theme/color_palette.dart';
import '../utils/image_picker_helper.dart';

/// Renders an image from either a data URL or a native file path.
/// Falls back to a placeholder if unavailable.
class ImageRefView extends StatelessWidget {
  final String? reference;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget Function()? placeholderBuilder;

  const ImageRefView({
    super.key,
    required this.reference,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.placeholderBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (reference == null || reference!.isEmpty) {
      return _placeholder();
    }

    if (ImagePickerHelper.isDataUrl(reference!)) {
      return _buildFromDataUrl(reference!);
    }

    if (kIsWeb) {
      // Legacy: an old record with a native path viewed on web.
      return _placeholder();
    }

    return _buildFromFile(reference!);
  }

  Widget _buildFromDataUrl(String dataUrl) {
    try {
      final commaIdx = dataUrl.indexOf(',');
      if (commaIdx < 0) return _placeholder();
      final b64 = dataUrl.substring(commaIdx + 1);
      final bytes = base64Decode(b64);
      return Image.memory(
        bytes,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    } catch (_) {
      return _placeholder();
    }
  }

  Widget _buildFromFile(String relativePath) {
    return FutureBuilder<String?>(
      future: ImagePickerHelper.resolveAbsolute(relativePath),
      builder: (context, snap) {
        if (!snap.hasData || snap.data == null) return _placeholder();
        return Image.file(
          File(snap.data!),
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, __, ___) => _placeholder(),
        );
      },
    );
  }

  Widget _placeholder() {
    if (placeholderBuilder != null) return placeholderBuilder!();
    return Container(
      width: width,
      height: height,
      color: IponColors.bgPlum,
      child: const Icon(Icons.image_outlined, color: IponColors.textDim),
    );
  }
}
