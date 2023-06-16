import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// if still get cut-off, let try to increase height of icons
class AppSvgImage extends StatelessWidget {
  const AppSvgImage({
    Key? key,
    required this.assetName,
    this.label,
    this.padding = EdgeInsets.zero,
    required this.width,
    required this.height,
    this.color,
    this.boxFit,
    this.isButton,
    this.useTooltip = false,
    this.messageTooltip = '',
  }) : super(key: key);
  final String assetName;
  final String? label;
  final EdgeInsets? padding;
  final bool? isButton;
  final double width;
  final double height;
  final bool useTooltip;
  final String messageTooltip;

  ///avoid use color, it will reduce performance
  final Color? color;
  final BoxFit? boxFit; //default is BoxFit.fill

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: isButton,
      child: Container(
        width: width.roundToDouble(),
        height: height.roundToDouble(),
        margin: EdgeInsets.only(
            top: padding!.top.roundToDouble(),
            right: padding!.right.roundToDouble(),
            left: padding!.left.roundToDouble(),
            bottom: padding!.bottom.roundToDouble()),
        child: buildChild(
          SvgPicture.asset(
            assetName,
            color: color,
            fit: boxFit ?? BoxFit.fill,
          ),
        ),
      ),
    );
    // return Semantics(
    //   label: label,
    //   child: Container(
    //     margin: EdgeInsets.only(
    //         top: padding!.top.roundToDouble(),
    //         right: padding!.right.roundToDouble(),
    //         left: padding!.left.roundToDouble(),
    //         bottom: padding!.bottom.roundToDouble()),
    //     child: Image(
    //       width: width.roundToDouble(),
    //       height: height.roundToDouble(),
    //       color: color,
    //       semanticLabel: label,
    //       image: svg_provider.Svg(assetName,
    //           source: svg_provider.SvgSource.asset,
    //           size: Size(width.roundToDouble(), height.roundToDouble())),
    //     ),
    //   ),
    // );
  }

  Widget buildChild(Widget child) {
    if (useTooltip) {
      return Tooltip(
        message: messageTooltip,
        child: child,
      );
    } else {
      return child;
    }
  }
}
