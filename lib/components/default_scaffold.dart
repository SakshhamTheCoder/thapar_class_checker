import 'package:flutter/material.dart';
import 'package:thapar_class_checker/pages/selection.dart';

Widget defaultScaffold(
    {required BuildContext context,
    required Widget body,
    bool isHome = false}) {
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      leading: isHome
          ? null
          : IconButton(
              icon: const Icon(
                Icons.home_filled,
                size: 32,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SelectionPage()),
                );
              },
            ),
      titleTextStyle: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
      toolbarHeight: 70,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16))),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text("Thapar Class Checker"),
      centerTitle: true,
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () {},
      label: Text("Show full timetable"),
      icon: Icon(Icons.calendar_month_outlined),
    ),
    body: body,
  );
}
