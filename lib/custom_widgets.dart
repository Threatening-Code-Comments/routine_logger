import 'package:flutter/material.dart';

import 'fab.dart';
import 'routine.dart';

class SizedCard extends StatefulWidget {
  const SizedCard({
    this.height,
    this.width,
    this.margin,
    this.alignment,
    this.child,
    super.key,
    this.elevation,
    this.onTap,
    double? cornerRadius,
    this.enabled = true,
    this.shape,
    this.stroke,
    bool? transparent,
    double? strokeWidth,
  })  : transparent = transparent ?? false,
        strokeWidth = strokeWidth ?? 10,
        cornerRadius = cornerRadius ?? 20;

  final void Function()? onTap;

  final bool enabled;
  final bool transparent;
  final Color? stroke;
  final double strokeWidth;

  final double? height;
  final double? width;

  final Widget? child;

  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;

  final ShapeBorder? shape;
  final double? cornerRadius;
  final double? elevation;

  @override
  State<SizedCard> createState() => _SizedCardState();
}

class _SizedCardState extends State<SizedCard> {
  @override
  Widget build(BuildContext context) {
    //set card color according to transparent or enabled
    Color? cardColor = getCardColor(context);

    //set card shape to a shape or to rounded corners
    ShapeBorder? shape = getShape();

    return Card(
        shape: shape,
        color: cardColor,
        elevation: 0, //widget.elevation,
        margin: widget.margin,
        child: InkWell(
            customBorder: shape,
            onTap: widget.onTap,
            child: Container(
              height: widget.height,
              width: widget.width,
              alignment: widget.alignment,
              child: widget.child,
            )));
  }

  ShapeBorder? getShape() {
    ShapeBorder? shape;

    if (widget.shape != null) {
      shape = widget.shape!;
    } else {
      if (widget.cornerRadius != null) {
        shape = RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.cornerRadius!),
            side: (widget.stroke == null)
                ? BorderSide.none
                : BorderSide(color: widget.stroke!, width: widget.strokeWidth));
      } else {
        shape = null;
      }
    }

    return shape;
  }

  Color? getCardColor(BuildContext context) {
    if (widget.transparent) return Colors.transparent;

    if (!widget.enabled) return Theme.of(context).cardColor.withOpacity(0.5);

    //return the normal card color if no flag is set
    return null;
  }
}

//------------------------------------------------------------------------------
///[Icon] with a size and a [Gradient]-Background.
class GradientIcon extends StatelessWidget {
  const GradientIcon(
      {required this.icon,
      required this.size,
      required this.gradient,
      this.shadows,
      super.key});

  final IconData icon;
  final double size;
  final Gradient gradient;

  final List<Shadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          shadows: shadows,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}

//------------------------------------------------------------------------------
class RoutineIcon extends StatelessWidget {
  const RoutineIcon(
      {this.margin,
      this.size,
      required this.icon,
      this.dropshadowBlur,
      this.colors,
      super.key});

  final double? margin;
  final double? size;

  final IconData icon;

  final double? dropshadowBlur;

  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    var colors = (this.colors == null)
        ? [Colors.white, Theme.of(context).colorScheme.primary]
        : this.colors!;
    double size = (this.size == null) ? 50 : this.size!;
    var margin = (this.margin == null) ? null : EdgeInsets.all(this.margin!);
    double dropshadowBlur =
        (this.dropshadowBlur == null) ? 4 : this.dropshadowBlur!;

    List<Shadow>? iconShadow = (debug_enableDropShadow)
        ? <Shadow>[
            Shadow(
                color: const Color.fromARGB(172, 0, 0, 0),
                blurRadius: dropshadowBlur)
          ]
        : null;

    return Container(
      margin: margin,
      child: GradientIcon(
        size: size,
        shadows: iconShadow,
        icon: icon,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
