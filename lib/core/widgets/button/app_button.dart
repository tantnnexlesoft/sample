import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  const AppButton({
    Key? key,
    this.width,
    this.height,
    this.splashRadius,
    required this.child,
    this.onTap,
    this.padding,
    this.onLongPress,
    this.borderRadius,
    this.disableHitState = false,
    this.onTapDown,
    this.useTooltip = false,
    this.messageTooltip = '',
  }) : super(key: key);
  final double? width;
  final double? height;
  final double? splashRadius;
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onTapDown;
  final EdgeInsets? padding;
  final GestureLongPressCallback? onLongPress;
  final BorderRadius? borderRadius;
  final bool disableHitState;
  final bool useTooltip;
  final String messageTooltip;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    Widget child = isPressed && !widget.disableHitState && widget.onTap != null
        ? ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.white54, BlendMode.srcATop),
            child: widget.child)
        : widget.child;
    return Material(
      color: Colors.transparent,
      child: InkWell(
          borderRadius: widget.borderRadius,
          onLongPress: widget.onLongPress,
          radius: widget.splashRadius,
          onTap: widget.onTap,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          // splashFactory: InkRipple.splashFactory,
          onTapDown: (_) {
            widget.onTapDown?.call();
            setState(() {
              isPressed = true;
            });
          },
          onTapUp: (_) async {
            if (!widget.disableHitState) {
              await Future.delayed(
                  const Duration(milliseconds: 100));
            }

            if (mounted) {
              setState(() {
                isPressed = false;
              });
            }
          },
          onTapCancel: () async {
            if (!widget.disableHitState) {
              await Future.delayed(
                  const Duration(milliseconds: 100));
            }
            if (mounted) {
              setState(() {
                isPressed = false;
              });
            }
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            padding: widget.padding ?? EdgeInsets.zero,
            child: (widget.width != null || widget.height != null)
                ? Center(child: buildChild(child))
                : buildChild(child),
          )),
    );
  }

  Widget buildChild(Widget child) {
    if (widget.useTooltip) {
      return Tooltip(
        message: widget.messageTooltip,
        child: child,
      );
    } else {
      return child;
    }
  }
}
