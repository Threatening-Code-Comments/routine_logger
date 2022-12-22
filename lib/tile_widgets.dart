import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:routine_logger/routine_page.dart';

import 'custom_widgets.dart';
import 'routine.dart';

//------------------------------------------------------------------------------
class TileWidget extends StatefulWidget {
  const TileWidget({
    super.key,
    required this.tile,
    required this.onWidgetTap,
    Function()? onDragCompleted,
    bool? hover,
    required this.coordinate,
  })  : hover = hover ?? false,
        onDragCompleted = onDragCompleted ?? _func;

  static void _func() {
    Fluttertoast.showToast(msg: 'No callback passed for TileWidget.');
  }

  final Tile tile;
  final void Function(int index) onWidgetTap;
  final void Function() onDragCompleted;
  final Point coordinate;

  final bool hover;

  @override
  State<TileWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> {
  @override
  Widget build(BuildContext context) {
    Widget card = (widget.tile.enabled)
        ? EnabledCard(tile: widget.tile)
        : DisabledCard(tile: widget.tile);
    if (widget.hover) card = const HoverCard();
    if (!widget.tile.isVisible) card = BackgroundCard(hover: widget.hover);

    return LongPressDraggable<Tile>(
        data: widget.tile,
        dragAnchorStrategy: pointerDragAnchorStrategy,
        feedback: SizedCard(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            child: Text(widget.tile.name)),
        childWhenDragging: DisabledCard(tile: widget.tile),
        onDragCompleted: () => widget.onDragCompleted,
        child: card);
  }
}

class BackgroundCard extends StatefulWidget {
  const BackgroundCard({super.key, bool? hover}) : hover = hover ?? false;

  final bool hover;

  @override
  State<BackgroundCard> createState() => _BackgroundCardState();
}

class _BackgroundCardState extends State<BackgroundCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.hover) return const HoverCard();

    return Container();
  }
}

//------------------------------------------------------------------------------
class EnabledCard extends StatefulWidget {
  const EnabledCard({
    super.key,
    TileWidgetTapFunction? onWidgetTap,
    required this.tile,
  }) : onWidgetTap = onWidgetTap ?? _func;

  static dynamic _func(int index) {}

  final TileWidgetTapFunction onWidgetTap;
  final Tile tile;

  @override
  State<EnabledCard> createState() => _EnabledCardState();
}

class _EnabledCardState extends State<EnabledCard> {
  @override
  Widget build(BuildContext context) {
    return SizedCard(
        onTap: () => widget.onWidgetTap,
        alignment: Alignment.center,
        cornerRadius: 10,
        child: Text(widget.tile.name));
  }
}

//------------------------------------------------------------------------------
///Card for use in TileWidget
class DisabledCard extends StatefulWidget {
  const DisabledCard({super.key, required this.tile, this.onWidgetTap});

  final Tile tile;
  final TileWidgetTapFunction? onWidgetTap;

  @override
  State<DisabledCard> createState() => _DisabledCardState();
}

class _DisabledCardState extends State<DisabledCard> {
  @override
  Widget build(BuildContext context) {
    return SizedCard(
        alignment: Alignment.center,
        enabled: false,
        cornerRadius: 10,
        onTap: () => widget.onWidgetTap,
        child: Text(widget.tile.name));
  }
}

//------------------------------------------------------------------------------
///Card for use in TileWidget
class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  @override
  Widget build(BuildContext context) {
    return SizedCard(
      alignment: Alignment.center,
      cornerRadius: 10,
      transparent: true,
      stroke: Theme.of(context).colorScheme.primary,
      strokeWidth: 2,
      child: Icon(
        Icons.loop,
        size: 50,
        color: Theme.of(context).backgroundColor,
      ),
    );
  }
}
