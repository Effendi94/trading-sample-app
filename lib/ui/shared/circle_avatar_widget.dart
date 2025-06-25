import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleAvatarWidget extends StatelessWidget {
  final double radius;
  final String? assetPath;
  final String? networkUrl;
  final bool isSvg;
  const CircleAvatarWidget({
    super.key,
    required this.radius,
    this.isSvg = false,
    this.assetPath,
    this.networkUrl,
  }) : assert(
         assetPath != null || networkUrl != null,
         'Either assetPath or networkUrl must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return _buildAvatarContent();
  }

  Widget _buildAvatarContent() {
    if (isSvg) {
      Widget svgImage;
      if (assetPath != null) {
        svgImage = SvgPicture.asset(
          assetPath!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
        );
      } else {
        svgImage = SvgPicture.network(
          networkUrl!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
        );
      }

      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.transparent,
        child: ClipOval(child: svgImage),
      );
    } else {
      // Raster image (asset or network) goes in backgroundImage
      ImageProvider imageProvider =
          assetPath != null ? AssetImage(assetPath!) : NetworkImage(networkUrl!) as ImageProvider;

      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.transparent,
        backgroundImage: imageProvider,
      );
    }
  }
}
