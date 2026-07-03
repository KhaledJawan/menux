import 'package:flutter/material.dart';
import 'image/local_image.dart';

/// Renders a menu item's photo from either a pasted link (http/https —
/// works everywhere including web) or a path copied in from the device's
/// gallery (native/desktop only — see local_image_web.dart for why that
/// path is a no-op on the web build). Falls back to a placeholder icon
/// when there's no image, or the image fails to load.
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final String? path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  bool get _isNetwork => path != null && (path!.startsWith('http://') || path!.startsWith('https://'));

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(12);
    return ClipRRect(
      borderRadius: radius,
      child: SizedBox(
        width: width,
        height: height,
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (path == null || path!.isEmpty) return _placeholder(context);
    if (_isNetwork) {
      return Image.network(
        path!,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, progress) =>
            progress == null ? child : Center(child: _placeholder(context, loading: true)),
        errorBuilder: (context, error, stackTrace) => _placeholder(context),
      );
    }
    return buildLocalImage(
      path!,
      width: width,
      height: height,
      fit: fit,
      placeholderBuilder: (context) => _placeholder(context),
    );
  }

  Widget _placeholder(BuildContext context, {bool loading = false}) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      color: theme.colorScheme.onSurface.withValues(alpha: 0.06),
      alignment: Alignment.center,
      child: loading
          ? SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            )
          : Icon(
              Icons.image_outlined,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
    );
  }
}
