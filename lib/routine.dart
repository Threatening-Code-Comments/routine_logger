import 'dart:math';

import 'package:flutter/material.dart';

import 'Tile.dart';
import 'routine_list.dart';

export 'Tile.dart';

RoutineList routines = RoutineList([
  Routine(name: 'Routine 1', icon: Icons.abc, tiles: [
    Tile.withSizes(
      name: 'Tile1',
      xStart: 1,
      yStart: 0,
      height: 2,
      width: 2,
    ),
    Tile.withSizes(
      name: 'Tile2',
      xStart: 0,
      yStart: 1,
      width: 1,
      height: 1,
    ),
    Tile.withSizes(
      name: 'Tile3',
      xStart: 0,
      width: 3,
      yStart: 2,
      height: 1,
    )
  ]),
  Routine(name: 'Routine name 2', icon: Icons.pause)
]);

final _random = Random();
R chooseRandom<R>(Set set) {
  return set.elementAt(_random.nextInt(set.length));
}

class Routine {
  String name;
  IconData icon;

  int mode = 0;

  List<Tile> tiles = [];

  Map<Point, Tile> get tileMap {
    Map<Point, Tile> map = {};

    for (Tile tile in tiles) {
      for (var x in tile.bounds.x.asIterable) {
        for (var y in tile.bounds.y.asIterable) {
          map[Point(x, y)] = tile;
        }
      }
    }

    return map;
  }

  final int id = Random().nextInt(100000);

  String get modeAsString => 'Continuous';

  Routine(
      {required this.name,
      required this.icon,
      List<Tile>? tiles,
      bool? isEmpty})
      : tiles = tiles ?? [] {
    this.isEmpty = (isEmpty == null) ? false : isEmpty;
  }

  Routine.empty()
      : this(icon: Icons.grading, name: 'brumm brumm', isEmpty: true);

  bool isEmpty = false;

  static final _randomIcons = {
    Icons.add,
    Icons.abc,
    Icons.account_balance_outlined,
    Icons.accessibility,
    Icons.accessible_outlined
  };

  static Routine random() {
    var randomNum = Random().nextInt(100);

    String randomName = "RanRout. Nr. $randomNum";
    IconData randomIcon = chooseRandom(_randomIcons);

    return Routine(name: randomName, icon: randomIcon);
  }

  static final Routine emptyRoutine = Routine.empty();
}
