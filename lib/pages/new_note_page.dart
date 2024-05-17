import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apad/models/note.dart';
import 'package:apad/db/note_database.dart';
import 'package:apad/pages/notes_page.dart';
import 'package:google_fonts/google_fonts.dart';

class NewNotePage extends StatefulWidget {
  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final TextEditingController _controller = TextEditingController();

  Future<void> createNote() async {
    try {
      await context.read<NoteDatabase>().addNote(_controller.text);
      _controller.clear();
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => NotesPage(),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving note: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => NotesPage(),
            ));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.format_bold),
            onPressed: () {
              // Handle bold formatting
            },
          ),
          IconButton(
            icon: Icon(Icons.format_underline),
            onPressed: () {
              // Handle underline formatting
            },
          ),
          IconButton(
            icon: Icon(Icons.format_italic),
            onPressed: () {
              // Handle italic formatting
            },
          ),
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () {
              // Handle text color change
            },
          ),
          IconButton(
            icon: Icon(Icons.format_size),
            onPressed: () {
              // Handle text font size change
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New note',
              style: GoogleFonts.dmSerifText(
                fontSize: 30,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Enter your note here...',
                    border: InputBorder.none, // Remove the border to match the container's rounded corners
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            createNote();
          },
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
