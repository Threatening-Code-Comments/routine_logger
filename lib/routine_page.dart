import 'dart:developer' as dev;
import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:routine_logger/custom_widgets.dart';
import 'package:routine_logger/tile_widgets.dart';
import 'inherited.dart';

import 'routine.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key, required this.routine});

  final Routine routine;

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  void onFabPress() {
    setState(() {
      widget.routine.tiles = [
        /* Tile(
                  name: 'Tile 01',
                  bounds: Bounds(
                    x: Range(0, 2),
                    y: Range(0, 1),
                  )),
              Tile(
                  name: 'Tile 02',
                  bounds: Bounds(
                    x: Range(2, 3),
                    y: Range(0, 1),
                  )),
              //-------------y=1
              Tile(
                  name: 'Tile 03',
                  bounds: Bounds(
                    x: Range(0, 2),
                    y: Range(1, 3),
                  )),
              Tile(
                  name: 'Tile 04',
                  bounds: Bounds(
                    x: Range(2, 3),
                    y: Range(1, 2),
                  )),
              //-------------------y=2
              Tile(
                  name: 'Tile 05',
                  bounds: Bounds(
                    x: Range(2, 3),
                    y: Range(2, 3),
                  )),
              //---------------y=3 */
        Tile(
            name: 'Tile 06',
            bounds: Bounds(
              x: Range(0, 3),
              y: Range(3, 4),
            )),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: onFabPress,
          //Navigator.pop(context);
          child: const Icon(Icons.ac_unit_outlined),
        ),
        body: CurrentRoutine(
          routine: widget.routine,
          child: Column(children: [
            SizedBox(
              height: 300,
              child: Column(children: const [
                Spacer(flex: 2),
                RoutineInfoWidget(),
                Spacer(flex: 1),
              ]),
            ),
            const Divider(),
            // ignore: prefer_const_constructors
            Expanded(
              // ignore: prefer_const_constructors
              child: RoutineWidgetSubpage(),
            )
          ]),
        ));
  }
}

//------------------------------------------------------------------------------
class RoutineWidgetSubpage extends StatefulWidget {
  const RoutineWidgetSubpage({super.key});

  @override
  State<RoutineWidgetSubpage> createState() => _RoutineWidgetSubpageState();
}

typedef TileWidgetTapFunction = void Function(int index);

class _RoutineWidgetSubpageState extends State<RoutineWidgetSubpage> {
  late Routine routine;

  List<BruhWidget> getTileWidgets() {
    List<BruhWidget> widgets = [];

    var tiles = routine.tiles;

    for (Tile tile in tiles) {
      widgets.add(BruhWidget.fromTile(
        tile,
        startDrag: startDrag,
        endDrag: endDrag,
      ));
    }

    return widgets;
  }

  bool _ignorePointer = true;

  void startDrag() {
    setState(() => _ignorePointer = false);
  }

  void endDrag() {
    setState(() => _ignorePointer = true);
  }

  @override
  Widget build(BuildContext context) {
    routine = CurrentRoutine.of(context).routine;
    var widgets = getTileWidgets();
    var gridPlacements = <GridPlacement>[];

    var rowSizes = <TrackSize>[];

    var size = (MediaQuery.of(context).size.width) / 3;

    for (BruhWidget widget in widgets) {
      while (widget.bounds.y.to > rowSizes.length) {
        rowSizes.add(size.px);
      }

      var x = widget.bounds.x;
      var y = widget.bounds.y;
      gridPlacements.add(widget.withGridPlacement(
          columnStart: x.from,
          columnSpan: x.size,
          rowStart: y.from,
          rowSpan: y.size));
    }

    if (rowSizes.isEmpty) rowSizes.add(size.px);

    var columnSizes = [1.fr, 1.fr, 1.fr];

    return SingleChildScrollView(
        child: Stack(children: [
      SizedBox(
        height: 2000,
        child: LayoutGrid(
          columnSizes: columnSizes,
          rowSizes: rowSizes,
          children: gridPlacements,
        ),
      ),
      SizedBox(
          height: 2000,
          child: DragTargetLayout(
              width: columnSizes.length,
              height: rowSizes.length,
              ignorePointer: _ignorePointer))
    ]));
  }
}

class DragTargetLayout extends StatefulWidget {
  const DragTargetLayout(
      {super.key,
      required this.width,
      required this.height,
      required this.ignorePointer});

  final int width;
  final int height;

  final bool ignorePointer;

  @override
  State<DragTargetLayout> createState() => _DragTargetLayoutState();
}

class _DragTargetLayoutState extends State<DragTargetLayout> {
  @override
  Widget build(BuildContext context) {
    var ignorePointer = widget.ignorePointer;
    var width = widget.width;
    var height = widget.height;

    return IgnorePointer(
        ignoring: ignorePointer,
        child: GridView.count(
          padding: const EdgeInsets.all(0),
          crossAxisCount: width,
          children: List.generate(
              width * (height + 1),
              (index) => TileDragReceiver(
                  width: width, index: index, ignorePointer: ignorePointer)),
        ));
  }
}

class TileDragReceiver extends StatefulWidget {
  TileDragReceiver(
      {super.key,
      required this.width,
      required this.index,
      required this.ignorePointer})
      : coordinate = Point(
          //index 5 => |1, 2|
          (index % width), //5 mod 3 = 2
          (index / width).floor(), //5 / 3 = 1,66 ----floor---> 1
        );

  final int width;
  final int index;

  final Point coordinate;

  bool ignorePointer = true;

  @override
  State<TileDragReceiver> createState() => _TileDragReceiverState();
}

class _TileDragReceiverState extends State<TileDragReceiver>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blue, end: Colors.transparent)
        .animate(controller)
      ..addListener(() {
        setState(() {
          _stroke_color = animation.value ?? Colors.green;
        });
      });
  }

  void animateColor() {
    controller.reset();
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Color _stroke_color = Colors.transparent;

  Tile? getTileOrNullAt({required int x, required int y}) {
    return routine.tileMap[Point(x, y)];
  }

  Tile? get tile => getTileOrNullAt(
      x: widget.coordinate.x.toInt(), y: widget.coordinate.y.toInt());

  bool isFree() {
    //access tileMap with the coordinate of this widget
    //if there is no tile at this position, returns null
    return getTileOrNullAt(
          x: widget.coordinate.x.toInt(),
          y: widget.coordinate.y.toInt(),
        ) ==
        null;
  }

  late Routine routine;

  @override
  Widget build(BuildContext context) {
    routine = CurrentRoutine.of(context).routine;

    return DragTarget<Tile>(
      builder: (context, candidateData, rejectedData) => SizedCard(
          stroke: _stroke_color,
          transparent: true,
          cornerRadius: 10,
          strokeWidth: 4),
      onWillAccept: (data) => true, //isFree(),
      onMove: (details) {
        /* tile.enabled = false;
        tile.bounds.moveToPoint(coordinate); */
        setState(() {
          var tile = details.data;

          _stroke_color = (isFree()) ? Colors.amber : Colors.blueAccent;

          if (tile == null) return;

          tile.tempBounds = tile.bounds;
          tile.tempBounds!.moveToPoint(widget.coordinate, widget.width);

          //move tile
          moveTile(tile);
        });
      },
      onLeave: (data) {
        setState(() {
          _stroke_color = Colors.transparent;
        });
      },
      onAccept: (data) => setState(() {
        animateColor();
        data.bounds.moveToPoint(widget.coordinate, widget.width);
      }),
    );
  }

  void moveTile(Tile tile) {
    var tileMap = routine.tileMap;

    var bounds = tile.tempBounds ?? tile.bounds;

    //the tile is supposed to be put into this position:
    //widget.coordinate

    //obstructing it is everything it would overlap.
    //getting these tiles: start -> width and start -> height
    var tilesToMove = <Tile>{};
    for (int x in bounds.x.asIterable) {
      for (int y in bounds.y.asIterable) {
        var p = Point(x, y);
        var tileAtPos = tileMap[p];

        if (tileAtPos != null && tileAtPos != tile) {
          tilesToMove.add(tileAtPos);
        }
      }
    }

    for (var tileToToggle in routine.tiles) {
      tileToToggle.enabled = (tileToToggle != tile);
    }

    //iterate through the tiles and move them out of the way for the tile
    //that is supposed to be dropped.
    if (tilesToMove.isEmpty) return; //throw Error();

    for (var tileToMove in tilesToMove) {
      tileToMove.enabled = false;
    }
  }
}

//------------------------------------------------------------------------------
class BruhWidget extends StatefulWidget {
  BruhWidget(
      {super.key,
      Bounds? bounds,
      required this.tile,
      String? text,
      double? margin,
      Function? startDrag,
      Function? endDrag,
      bool? isVisible})
      : text = text ?? tile.name,
        bounds = bounds ?? tile.bounds,
        isVisible = isVisible ?? true,
        startDrag = startDrag ?? (() {}),
        endDrag = endDrag ?? (() {});

  BruhWidget.fromTile(Tile tile,
      {Key? key, Function? startDrag, Function? endDrag})
      : this(
            key: key,
            tile: tile,
            bounds: tile.bounds,
            startDrag: startDrag,
            endDrag: endDrag);

  final Function startDrag;
  final Function endDrag;

  final Bounds bounds;
  final Tile tile;

  final bool isVisible;

  final String text;

  @override
  State<BruhWidget> createState() => _BruhWidgetState();
}

class _BruhWidgetState extends State<BruhWidget> {
  @override
  Widget build(BuildContext context) {
    var tile = widget.tile;
    var text = widget.text;
    var bounds = widget.bounds;

    var stroke = (tile.enabled) ? null : Theme.of(context).colorScheme.primary;
    double? strokeWidth = (tile.enabled) ? null : 4;

    var tileCard = SizedCard(
      cornerRadius: 10,
      transparent: !tile.enabled,
      stroke: stroke,
      strokeWidth: strokeWidth,
      child: Center(
          child: Column(
        children: [
          const Spacer(),
          const Icon(Icons.add_location_alt_outlined),
          Text(text),
          const Spacer(),
        ],
      )),
    );

    return LongPressDraggable<Tile>(
      feedback: SizedCard(
          height: (100 * bounds.height).toDouble(),
          width: (100 * bounds.width).toDouble(),
          child: Center(
              child: Column(
            children: [
              const Spacer(),
              const Icon(Icons.add_location_alt_outlined),
              Text(text),
              const Spacer(),
            ],
          ))),
      data: tile,
      onDragStarted: () => setState(() {
        tile.enabled = false;
        widget.startDrag();
      }),
      onDragEnd: (details) => setState(() {
        tile.enabled = true;
        widget.endDrag();
      }),
      child: tileCard,
    );
  }
}

//------------------------------------------------------------------------------
class TileWidgetReceiver extends StatefulWidget {
  const TileWidgetReceiver(
      {super.key,
      required this.tile,
      required this.coordinate,
      this.flex = 1,
      required this.onWidgetTap});

  final Tile tile;
  final Point coordinate;

  final Function(int) onWidgetTap;

  final int flex;

  @override
  State<TileWidgetReceiver> createState() => _TileWidgetReceiverState();
}

class _TileWidgetReceiverState extends State<TileWidgetReceiver> {
  bool _hover = false;
  Tile? _tile;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: widget.flex,
        child: AspectRatio(
          aspectRatio: 1,
          child: DragTarget<Tile>(
            builder: (context, _, __) => TileWidget(
              tile: _tile ?? widget.tile,
              hover: _hover,
              coordinate: widget.coordinate,
              onWidgetTap: widget.onWidgetTap,
              onDragCompleted: () =>
                  setState(() => _tile = Tile.empty()..isVisible = false),
            ),
            onAccept: ((data) =>
                setState(() => {_tile = data, _hover = false})),
            onMove: (details) => setState(() => _hover = true),
            onLeave: (data) => setState(() => _hover = false),
          ),
        ));
  }
}

//------------------------------------------------------------------------------
class RoutineInfoWidget extends StatelessWidget {
  const RoutineInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Routine routine = CurrentRoutine.of(context).routine;
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return SizedCard(
      height: 150,
      width: 375,
      elevation: 8,
      cornerRadius: 20,
      child: Center(
          child: Row(
        children: [
          RoutineIcon(
            //margin: 10,
            dropshadowBlur: 4,
            size: 75,
            icon: routine.icon,
          ),
          Flexible(
              child: Text(
            style: textTheme.titleLarge,
            routine.name,
            overflow: TextOverflow.fade,
          )),
        ],
      )),
    );
  }
}
