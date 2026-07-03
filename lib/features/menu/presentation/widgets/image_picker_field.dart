import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/app_text_field.dart';

/// Menu item photo picker: paste a link, or upload from the device's
/// gallery (native/desktop only — the web build has no local file
/// persistence, so "upload" there wouldn't survive a refresh anyway).
class ImagePickerField extends StatefulWidget {
  const ImagePickerField({super.key, required this.imagePath, required this.onChanged});

  final String? imagePath;
  final ValueChanged<String?> onChanged;

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  bool _isUploading = false;

  Future<void> _pasteLink() async {
    final controller = TextEditingController(
      text: widget.imagePath != null && widget.imagePath!.startsWith('http') ? widget.imagePath : '',
    );
    final url = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Image Link'),
        content: AppTextField(controller: controller, label: 'Image URL', autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (url != null && url.isNotEmpty) widget.onChanged(url);
  }

  Future<void> _uploadFromDevice() async {
    setState(() => _isUploading = true);
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1600);
      if (picked == null) return;
      final imagesDir = Directory(p.join((await getApplicationDocumentsDirectory()).path, 'menu_images'));
      if (!imagesDir.existsSync()) imagesDir.createSync(recursive: true);
      final fileName = '${DateTime.now().millisecondsSinceEpoch}${p.extension(picked.path)}';
      final saved = await File(picked.path).copy(p.join(imagesDir.path, fileName));
      widget.onChanged(saved.path);
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppImage(path: widget.imagePath, width: 72, height: 72),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Photo (optional)', style: theme.textTheme.bodyMedium),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  AppButton(
                    label: 'Paste Link',
                    variant: AppButtonVariant.secondary,
                    expand: false,
                    onPressed: _pasteLink,
                  ),
                  if (!kIsWeb)
                    AppButton(
                      label: 'Upload from Device',
                      variant: AppButtonVariant.secondary,
                      expand: false,
                      isLoading: _isUploading,
                      onPressed: _uploadFromDevice,
                    ),
                  if (widget.imagePath != null)
                    AppButton(
                      label: 'Remove',
                      variant: AppButtonVariant.text,
                      expand: false,
                      onPressed: () => widget.onChanged(null),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
