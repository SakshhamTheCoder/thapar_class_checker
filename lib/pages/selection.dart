import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thapar_class_checker/components/default_scaffold.dart';
import 'package:thapar_class_checker/utils/shared_preferences_utils.dart';

import 'home.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  late String selectedBatch = "";
  late String selectedGroup = "";

  @override
  Widget build(BuildContext context) {
    return defaultScaffold(
      isHome: true,
      context: context,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "View Timetable",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: rootBundle.loadString("assets/data.json"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }
                if (snapshot.hasData) {
                  var batch = json.decode(snapshot.data).keys.toList();
                  var group = [];
                  if (selectedBatch != "") {
                    group = json.decode(snapshot.data)[selectedBatch].keys.toList();
                  }
                  return Column(
                    children: [
                      DropdownMenu(
                          hintText: "Select Batch",
                          menuHeight: 300,
                          width: 300,
                          onSelected: (String? value) {
                            setState(() {
                              selectedBatch = value!;
                            });
                          },
                          dropdownMenuEntries: batch.map<DropdownMenuEntry<String>>((value) {
                            return DropdownMenuEntry<String>(
                              value: value,
                              label: value,
                              enabled: true,
                            );
                          }).toList()),
                      SizedBox(height: 5),
                      DropdownMenu(
                          hintText: "Select Group",
                          menuHeight: 300,
                          width: 300,
                          onSelected: (String? value) {
                            setState(() {
                              selectedGroup = value!;
                            });
                          },
                          dropdownMenuEntries: group.map<DropdownMenuEntry<String>>((value) {
                            return DropdownMenuEntry<String>(
                              value: value,
                              label: value,
                              enabled: true,
                            );
                          }).toList()),
                    ],
                  );
                }
                return const Text("No data");
              },
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                if (selectedBatch == "" || selectedGroup == "") {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      showCloseIcon: true,
                      content: Text("Please select batch and group"),
                    ),
                  );
                  return;
                }
                SharedPrefs.instance.setString("batch", selectedBatch);
                SharedPrefs.instance.setString("group", selectedGroup);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return HomePage(
                      batchName: selectedBatch,
                      groupName: selectedGroup,
                    );
                  },
                ));
              },
              child: const Text("Get Schedule"),
            ),
          ],
        ),
      ),
    );
  }
}
