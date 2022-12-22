import 'package:flutter/material.dart';
import 'package:routine_logger/custom_widgets.dart';
import 'package:routine_logger/fab.dart';
import 'package:routine_logger/routine_page.dart';

import 'routine.dart';

//------------------------------------------------------------------------------
///home page containing scaffold with widgets
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onFabClick() {
    globalDoOnFabClick(this);
  }

  void onFabLongPress() {
    globalDoOnFabLongPress(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: HomePageFab(
        onClick: onFabClick,
        onLongPress: onFabLongPress,
      ),
      body: Column(children: [
        HomePageInfoDisplay(marginTop: 75, routineSize: routines.length),
        const Divider(),
        RoutineList(
          routines: routines,
        )
      ]),
    );
  }
}

//------------------------------------------------------------------------------
///fab to add [routines][Routine].
class HomePageFab extends StatefulWidget {
  const HomePageFab({super.key, required this.onClick, this.onLongPress});

  final Function() onClick;
  final Function()? onLongPress;

  @override
  State<HomePageFab> createState() => _HomePageFabState();
}

class _HomePageFabState extends State<HomePageFab> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: widget.onLongPress,
        child: FloatingActionButton(
          onPressed: widget.onClick,
          child: const Icon(Icons.toggle_on),
        ));
  }
}

//------------------------------------------------------------------------------
///Display for title and routine count
class HomePageInfoDisplay extends StatefulWidget {
  const HomePageInfoDisplay(
      {super.key, required this.routineSize, required this.marginTop});

  final int routineSize;
  final double marginTop;

  @override
  State<HomePageInfoDisplay> createState() => _HomePageInfoDisplayState();
}

class _HomePageInfoDisplayState extends State<HomePageInfoDisplay> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedCard(
        height: 150,
        width: 350,
        elevation: 8,
        margin: EdgeInsets.fromLTRB(0, widget.marginTop, 0, 0),
        alignment: Alignment.center,
        cornerRadius: 20,
        child: Container(
            padding: const EdgeInsets.all(3),
            child: Center(
                child: Column(children: [
              const Spacer(),
              Text(
                  style: textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  'Your Routines'),
              Text(
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 20),
                  'you have ${widget.routineSize} :)'),
              const Spacer()
            ]))));
  }
}

//------------------------------------------------------------------------------
///List with [routine entries][RoutineEntry].
class RoutineList extends StatefulWidget {
  const RoutineList({this.routines, super.key});

  final routines;

  @override
  State<RoutineList> createState() => _RoutineListState();
}

class _RoutineListState extends State<RoutineList> {
  List<Widget> createRoutineWidgetList() {
    var widgetList = <RoutineEntry>[];

    for (var routine in widget.routines) {
      widgetList.add(RoutineEntry(routine));
    }

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
      shrinkWrap: true,
      children: createRoutineWidgetList(),
    ));
  }
}

//------------------------------------------------------------------------------
///Entry displaying Icon, title and mode of routine.
class RoutineEntry extends StatefulWidget {
  const RoutineEntry(this.routine, {super.key});

  final Routine routine;

  @override
  State<RoutineEntry> createState() => _RoutineEntryState();
}

class _RoutineEntryState extends State<RoutineEntry> {
  void onRoutineEntryClick() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RoutinePage(routine: widget.routine)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedCard(
        onTap: onRoutineEntryClick,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
        elevation: 4,
        height: 75,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            side: BorderSide.none),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Icon
            RoutineIcon(
              margin: 10,
              dropshadowBlur: 4,
              icon: widget.routine.icon,
            ),
            //Text
            Expanded(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //const Spacer(),
                          Text(
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(fontSize: 22.5),
                              widget.routine.name),

                          Text(
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 12.5,
                              ),
                              textAlign: TextAlign.start,
                              '${widget.routine.modeAsString} mode'),
                          //const Spacer()
                        ]))),
          ],
        ));
  }
}
