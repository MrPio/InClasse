import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:in_classe/extension_function/string_extensions.dart';

import '../../manager/storage_manager.dart';

class FirebaseImage extends StatefulWidget {
  final Collection collection;
  final String? filename;
  final double? width, height;

  /// Retrieves and displays the [filename] image from the Firebase Storage specified [collection].
  ///
  /// A shimmer effect is shown while the image is being fetched.
  /// A fallback image is shown if no [filename] is specified or the url is not valid.
  const FirebaseImage(
      {this.filename,
      this.collection = Collection.none,
      this.height,
      this.width = double.infinity,
      super.key});

  @override
  State<FirebaseImage> createState() => _FirebaseImageState();
}

class _FirebaseImageState extends State<FirebaseImage> {
  String? _imageUrl;

  @override
  void initState() {
    if (widget.filename != null)
      Future.delayed(Duration.zero, () async {
        _imageUrl = await StorageManager().fetchUrl(widget.collection, widget.filename!);
        if (mounted) setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var fallback = 'fallback.png'.toIcon(height: 80);
    var shimmer = Shimmer.fromColors(
      baseColor: Colors.white.withAlpha(35),
      highlightColor: Colors.white.withAlpha(70),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
    return widget.filename == null
        ? fallback
        : _imageUrl == null
            ? shimmer
            : ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: _imageUrl!,
                  width: widget.width,
                  height: widget.height,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => shimmer,
                  errorWidget: (context, url, error) => fallback,
                ),
              );
  }
}
