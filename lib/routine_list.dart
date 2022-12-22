import 'dart:math';

import 'package:routine_logger/routine.dart';
import 'package:collection/collection.dart';
import 'Tile.dart';

class RoutineList implements List<Routine> {
  @override
  late Routine first;

  @override
  late Routine last;

  @override
  late int length;

  List<Routine> _routines = [];

  RoutineList(List<Routine> routines) {
    _routines = routines;
    first = routines.first;
    last = routines.last;
    length = routines.length;
  }

  RoutineList.empty() {
    _routines = [];
    first = Routine.emptyRoutine;
    last = Routine.emptyRoutine;
    length = 0;
  }

  void deleteAt(int index) {
    _routines[index] = Routine.emptyRoutine;
  }

  Routine routineOf(Tile tile) {
    return _routines.firstWhere((element) => element.tiles.contains(tile));
  }

  @override
  List<Routine> operator +(List<Routine> other) {
    addAll(other);
    return this;
  }

  @override
  Routine operator [](int index) {
    return _routines[index];
  }

  @override
  void operator []=(int index, Routine value) {
    _routines[index] = value;
  }

  @override
  void add(Routine value) {
    _routines.add(value);
  }

  @override
  void addAll(Iterable<Routine> iterable) {
    _routines.addAll(iterable);
  }

  @override
  bool any(bool Function(Routine element) test) {
    return _routines.any(test);
  }

  @override
  Map<int, Routine> asMap() {
    return _routines.asMap();
  }

  @override
  List<R> cast<R>() {
    return _routines.cast<R>();
  }

  @override
  void clear() {
    _routines.clear();
  }

  @override
  bool contains(Object? element) {
    return _routines.contains(element);
  }

  @override
  Routine elementAt(int index) {
    return _routines.elementAt(index);
  }

  @override
  bool every(bool Function(Routine element) test) {
    // TODO: implement every
    throw UnimplementedError();
  }

  @override
  Iterable<T> expand<T>(Iterable<T> Function(Routine element) toElements) {
    // TODO: implement expand
    throw UnimplementedError();
  }

  @override
  void fillRange(int start, int end, [Routine? fillValue]) {
    // TODO: implement fillRange
  }

  @override
  Routine firstWhere(bool Function(Routine element) test,
      {Routine Function()? orElse}) {
    return _routines.firstWhere(test, orElse: orElse);
  }

  @override
  T fold<T>(
      T initialValue, T Function(T previousValue, Routine element) combine) {
    // TODO: implement fold
    throw UnimplementedError();
  }

  @override
  Iterable<Routine> followedBy(Iterable<Routine> other) {
    // TODO: implement followedBy
    throw UnimplementedError();
  }

  @override
  void forEach(void Function(Routine element) action) {
    _routines.forEach(action);
  }

  @override
  Iterable<Routine> getRange(int start, int end) {
    // TODO: implement getRange
    throw UnimplementedError();
  }

  @override
  int indexOf(Routine element, [int start = 0]) {
    return _routines.indexOf(element, start);
  }

  @override
  int indexWhere(bool Function(Routine element) test, [int start = 0]) {
    // TODO: implement indexWhere
    throw UnimplementedError();
  }

  @override
  void insert(int index, Routine element) {
    // TODO: implement insert
  }

  @override
  void insertAll(int index, Iterable<Routine> iterable) {
    // TODO: implement insertAll
  }

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  // TODO: implement isNotEmpty
  bool get isNotEmpty => throw UnimplementedError();

  @override
  // TODO: implement iterator
  Iterator<Routine> get iterator => _routines.iterator;

  @override
  String join([String separator = ""]) {
    // TODO: implement join
    throw UnimplementedError();
  }

  @override
  int lastIndexOf(Routine element, [int? start]) {
    // TODO: implement lastIndexOf
    throw UnimplementedError();
  }

  @override
  int lastIndexWhere(bool Function(Routine element) test, [int? start]) {
    // TODO: implement lastIndexWhere
    throw UnimplementedError();
  }

  @override
  Routine lastWhere(bool Function(Routine element) test,
      {Routine Function()? orElse}) {
    // TODO: implement lastWhere
    throw UnimplementedError();
  }

  @override
  Iterable<T> map<T>(T Function(Routine e) toElement) {
    // TODO: implement map
    throw UnimplementedError();
  }

  @override
  Routine reduce(Routine Function(Routine value, Routine element) combine) {
    // TODO: implement reduce
    throw UnimplementedError();
  }

  @override
  bool remove(Object? value) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Routine removeAt(int index) {
    // TODO: implement removeAt
    throw UnimplementedError();
  }

  @override
  Routine removeLast() {
    // TODO: implement removeLast
    throw UnimplementedError();
  }

  @override
  void removeRange(int start, int end) {
    // TODO: implement removeRange
  }

  @override
  void removeWhere(bool Function(Routine element) test) {
    // TODO: implement removeWhere
  }

  @override
  void replaceRange(int start, int end, Iterable<Routine> replacements) {
    // TODO: implement replaceRange
  }

  @override
  void retainWhere(bool Function(Routine element) test) {
    // TODO: implement retainWhere
  }

  @override
  // TODO: implement reversed
  Iterable<Routine> get reversed => throw UnimplementedError();

  @override
  void setAll(int index, Iterable<Routine> iterable) {
    // TODO: implement setAll
  }

  @override
  void setRange(int start, int end, Iterable<Routine> iterable,
      [int skipCount = 0]) {
    // TODO: implement setRange
  }

  @override
  void shuffle([Random? random]) {
    // TODO: implement shuffle
  }

  @override
  // TODO: implement single
  Routine get single => throw UnimplementedError();

  @override
  Routine singleWhere(bool Function(Routine element) test,
      {Routine Function()? orElse}) {
    // TODO: implement singleWhere
    throw UnimplementedError();
  }

  @override
  Iterable<Routine> skip(int count) {
    // TODO: implement skip
    throw UnimplementedError();
  }

  @override
  Iterable<Routine> skipWhile(bool Function(Routine value) test) {
    // TODO: implement skipWhile
    throw UnimplementedError();
  }

  @override
  void sort([int Function(Routine a, Routine b)? compare]) {
    // TODO: implement sort
  }

  @override
  List<Routine> sublist(int start, [int? end]) {
    // TODO: implement sublist
    throw UnimplementedError();
  }

  @override
  Iterable<Routine> take(int count) {
    // TODO: implement take
    throw UnimplementedError();
  }

  @override
  Iterable<Routine> takeWhile(bool Function(Routine value) test) {
    // TODO: implement takeWhile
    throw UnimplementedError();
  }

  @override
  List<Routine> toList({bool growable = true}) {
    // TODO: implement toList
    throw UnimplementedError();
  }

  @override
  Set<Routine> toSet() {
    // TODO: implement toSet
    throw UnimplementedError();
  }

  @override
  Iterable<Routine> where(bool Function(Routine element) test) {
    // TODO: implement where
    throw UnimplementedError();
  }

  @override
  Iterable<T> whereType<T>() {
    // TODO: implement whereType
    throw UnimplementedError();
  }

  Tile getTile({required int uid}) {
    Tile? tile;

    for (Routine routine in _routines) {
      tile = routine.tiles.firstWhereOrNull(
        (element) => element.id == uid,
      );
      if (tile != null) break;
    }

    if (tile == null) throw Exception("Coudn't find a tile with uid $uid.");

    return tile;
  }
}
