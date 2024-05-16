import 'package:apad/db/note_database.dart';
import 'package:apad/notes_page.dart';
import 'package:apad/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
//init database
WidgetsFlutterBinding.ensureInitialized();
await NoteDatabase.initialize();

  runApp(
    MultiProvider(providers: [

      ChangeNotifierProvider(create: (context) => NoteDatabase()),

      ChangeNotifierProvider(create: (context) => ThemeProvider())

    ],
    child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: const NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

