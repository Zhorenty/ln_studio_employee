import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/theme/theme.dart';
import '/src/common/utils/extensions/color_extension.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/utils/extensions/string_extension.dart';

/// Widget to build an [Avatar].
///
/// Displays a colored [BoxDecoration] with initials based on a [title].
class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    this.avatar,
    this.imageUrl,
    this.radius,
    this.maxRadius,
    this.minRadius,
    this.title,
    this.color,
    this.opacity = 1,
    this.isLabelVisible = false,
    this.label,
    this.onBadgeTap,
  });

  ///
  final File? avatar;

  ///
  final String? imageUrl;

  /// Size of the avatar, expressed as the radius (half the diameter).
  ///
  /// If [radius] is specified, then neither [minRadius] nor [maxRadius] may be
  /// specified. Specifying [radius] is equivalent to specifying a [minRadius]
  /// and [maxRadius], both with the value of [radius].
  ///
  /// If neither [minRadius] nor [maxRadius] are specified, defaults to 20
  /// logical pixels.
  final double? radius;

  /// The maximum size of the avatar, expressed as the radius (half the
  /// diameter).
  ///
  /// If [maxRadius] is specified, then [radius] must not also be specified.
  ///
  /// Defaults to [double.infinity].
  final double? maxRadius;

  /// The minimum size of the avatar, expressed as the radius (half the
  /// diameter).
  ///
  /// If [minRadius] is specified, then [radius] must not also be specified.
  ///
  /// Defaults to zero.
  final double? minRadius;

  /// Optional title of an avatar to display.
  final String? title;

  /// Integer that determining the gradient color of the avatar.
  final int? color;

  /// Opacity of this [AvatarWidget].
  final double opacity;

  /// Indicator whether to display an online [Badge] in the bottom-right corner
  /// of this [AvatarWidget].
  final bool isLabelVisible;

  /// Optional label to show inside this [AvatarWidget].
  final Widget? label;

  final void Function()? onBadgeTap;

  /// Returns minimum diameter of the avatar.
  double get _minDiameter {
    if (radius == null && minRadius == null && maxRadius == null) {
      return 40;
    }
    return 2.0 * (radius ?? minRadius ?? 20);
  }

  /// Returns maximum diameter of the avatar.
  double get _maxDiameter {
    if (radius == null && minRadius == null && maxRadius == null) {
      return 40;
    }
    return 2.0 * (radius ?? maxRadius ?? 40);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colors;
    return LayoutBuilder(
      builder: (context, constraints) {
        final Color gradient;

        if (color != null) {
          gradient = colors.avatarColors[color! % colors.avatarColors.length];
        } else if (title != null) {
          gradient = colors
              .avatarColors[(title!.hashCode) % colors.avatarColors.length];
        } else {
          gradient = const Color(0xFF666666);
        }

        double minWidth = min(_minDiameter, constraints.smallest.shortestSide);
        double minHeight = min(_minDiameter, constraints.smallest.shortestSide);
        double maxWidth = min(_maxDiameter, constraints.biggest.shortestSide);
        double maxHeight = min(_maxDiameter, constraints.biggest.shortestSide);

        final double badgeSize =
            maxWidth >= 40 ? maxWidth / 5 : maxWidth / 3.75;

        return GestureDetector(
          onTap: onBadgeTap,
          child: Badge(
            largeSize: badgeSize * 1.5,
            isLabelVisible: isLabelVisible,
            alignment: Alignment.bottomRight,
            backgroundColor: context.colorScheme.primaryContainer,
            padding: EdgeInsets.all(badgeSize / 12),
            offset:
                maxWidth >= 40 ? const Offset(-2.5, -2.5) : const Offset(0, 0),
            label: SizedBox(
              width: badgeSize * 1.4,
              child: Icon(
                Icons.photo_camera_rounded,
                color: context.colorScheme.onBackground,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(0.5),
                  constraints: BoxConstraints(
                    minHeight: minHeight,
                    minWidth: minWidth,
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [gradient.lighten(), gradient],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: label ??
                        SelectionContainer.disabled(
                          child: Text(
                            (title ?? '??').initials(),
                            style: context.textTheme.titleSmall!.copyWith(
                              fontSize: 16 * (maxWidth / 40.0),
                              color: context.colorScheme.secondary,
                              fontFamily: FontFamily.geologica,
                            ),

                            // Disable the accessibility size settings for
                            // this [Text].
                            textScaleFactor: 1,
                          ),
                        ),
                  ),
                ),
                if (avatar != null || imageUrl != null)
                  Positioned.fill(
                    child: ClipOval(
                      child: imageUrl != null
                          ? CachedNetworkImage(
                              imageUrl: imageUrl!,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              avatar!,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
