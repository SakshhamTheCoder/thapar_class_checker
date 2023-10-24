import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thapar_class_checker/pages/home.dart';
import 'package:thapar_class_checker/pages/selection.dart';
import 'package:thapar_class_checker/utils/shared_preferences_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var batch = SharedPrefs.instance.getString("batch");
    var group = SharedPrefs.instance.getString("group");
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Thapar Class Checker',
        theme: ThemeData(
          fontFamily: GoogleFonts.ptSans().fontFamily,
          colorScheme: ColorScheme.fromSeed(
              // seedColor: const Color.fromARGB(255, 98, 0, 255),
              seedColor: const Color.fromARGB(255, 236, 145, 38),
              brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: (batch != null && group != null)
            ? HomePage(batchName: batch!, groupName: group!)
            : const SelectionPage());
  }
}
