import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:thapar_class_checker/components/default_scaffold.dart';

import '../utils/utils.dart';

class HomePage extends StatefulWidget {
  final String batchName;
  final String groupName;

  const HomePage({super.key, required this.batchName, required this.groupName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var date = DateTime.now();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        date = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return defaultScaffold(
        isHome: false,
        context: context,
        body: Center(
          child: FutureBuilder(
              future: rootBundle.loadString('assets/data.json'),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }
                if (snapshot.hasData) {
                  var day = DateFormat('EEEE').format(date);
                  var dayIndex = Utils.days[day]!;
                  var timeIndex = Utils.currentClassTime(
                      DateTime.parse("1970-01-01 00:00:00.000").copyWith(hour: date.hour, minute: date.minute));
                  var nextTimeIndex = timeIndex > 0 && timeIndex < 14 ? timeIndex + 1 : 0;
                  var currentData = json.decode(snapshot.data)[widget.batchName][widget.groupName][timeIndex][dayIndex];

                  for (nextTimeIndex; nextTimeIndex < 15; nextTimeIndex++) {
                    if (json.decode(snapshot.data)[widget.batchName][widget.groupName][nextTimeIndex][dayIndex]
                            ['course'] !=
                        "") {
                      break;
                    }
                  }
                  if (nextTimeIndex > 13) {
                    nextTimeIndex = 0;
                  }
                  var nextData =
                      json.decode(snapshot.data)[widget.batchName][widget.groupName][nextTimeIndex][dayIndex];
                  String currentClass = (dayIndex != 0)
                      ? timeIndex != 0
                          ? currentData['course'].toString().isNotEmpty
                              ? currentData['course'].toString()
                              : "No class right now"
                          : "No class right now"
                      : "No class today";
                  String nextClass = (dayIndex != 0)
                      ? nextTimeIndex != 0
                          ? nextData['course'].toString().isNotEmpty
                              ? nextData['course'].toString()
                              : "No class right now"
                          : "No class right now"
                      : "No class today";
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(DateFormat('EEEE, d MMMM y').format(date),
                          textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
                      Text(DateFormat.jm().format(date),
                          textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineLarge),
                      const SizedBox(height: 50),
                      Text(
                        "${widget.batchName} - ${widget.groupName}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 50),
                      Card(
                        elevation: 5,
                        child: SizedBox(
                          height: 100,
                          width: 300,
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: RichText(
                                textScaleFactor: 1.2,
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style.copyWith(
                                      color: currentClass != "No class right now" &&
                                              currentClass != "No class today" &&
                                              currentClass.isNotEmpty
                                          ? (currentData['color'] == "success"
                                              ? Colors.green.shade300
                                              : currentData['color'] == "danger"
                                                  ? Colors.red.shade300
                                                  : currentData['color'] == "info"
                                                      ? Colors.blue.shade300
                                                      : Theme.of(context).colorScheme.onPrimaryContainer)
                                          : Theme.of(context).colorScheme.onPrimaryContainer),
                                  children: [
                                    const TextSpan(
                                      text: 'Current Class: ',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: currentClass,
                                    ),
                                    timeIndex != 0 &&
                                            currentClass != "No class right now" &&
                                            currentClass != "No class today" &&
                                            currentClass.isNotEmpty
                                        ? TextSpan(
                                            text: "\n ${Utils.times[timeIndex]}",
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          )
                                        : const TextSpan()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      dayIndex != 0 || timeIndex != 0
                          ? Card(
                              elevation: 5,
                              child: SizedBox(
                                height: 100,
                                width: 300,
                                child: Center(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: RichText(
                                      textScaleFactor: 1.2,
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: DefaultTextStyle.of(context).style.copyWith(
                                            color: nextClass != "No class right now" &&
                                                    nextClass != "No class today" &&
                                                    nextClass.isNotEmpty
                                                ? (nextData['color'] == "success"
                                                    ? Colors.green.shade300
                                                    : nextData['color'] == "danger"
                                                        ? Colors.red.shade300
                                                        : nextData['color'] == "info"
                                                            ? Colors.blue.shade300
                                                            : Theme.of(context).colorScheme.onPrimaryContainer)
                                                : Theme.of(context).colorScheme.onPrimaryContainer),
                                        children: [
                                          const TextSpan(
                                            text: 'Next Class: ',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: nextClass,
                                          ),
                                          timeIndex + 1 != 0 &&
                                                  nextClass != "No class right now" &&
                                                  nextClass != "No class today" &&
                                                  nextClass.isNotEmpty
                                              ? TextSpan(
                                                  text: "\n ${Utils.times[nextTimeIndex]}",
                                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                                )
                                              : const TextSpan()
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  );
                }
                return const Text("No data");
              }),
        ));
  }
}
