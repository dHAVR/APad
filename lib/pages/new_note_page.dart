import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apad/models/note.dart';
import 'package:apad/db/note_database.dart';
import 'package:apad/pages/notes_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_html/flutter_html.dart';

class NewNotePage extends StatefulWidget {
  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final TextEditingController _controller = TextEditingController();
  TextStyle _currentTextStyle = TextStyle();
  Color _currentColor = Colors.black;
  double _currentFontSize = 16.0;

  Future<void> createNote() async {
    try {
      final text = _convertTextToHtml(_controller.text, _currentTextStyle);
      await context.read<NoteDatabase>().addNote(
        text
      );
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

  void _toggleBold() {
    setState(() {
      _currentTextStyle = _currentTextStyle.copyWith(
        fontWeight: _currentTextStyle.fontWeight == FontWeight.bold
            ? FontWeight.normal
            : FontWeight.bold,
      );
    });
  }

  void _toggleUnderline() {
    setState(() {
      _currentTextStyle = _currentTextStyle.copyWith(
        decoration: _currentTextStyle.decoration == TextDecoration.underline
            ? TextDecoration.none
            : TextDecoration.underline,
      );
    });
  }

  void _toggleItalic() {
    setState(() {
      _currentTextStyle = _currentTextStyle.copyWith(
        fontStyle: _currentTextStyle.fontStyle == FontStyle.italic
            ? FontStyle.normal
            : FontStyle.italic,
      );
    });
  }

  void _changeTextColor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _currentColor,
            onColorChanged: (color) {
              setState(() {
                _currentColor = color;
                _currentTextStyle = _currentTextStyle.copyWith(color: color);
              });
            },
          ),
        ),
        actions: [
          TextButton(
            child: Text('Done'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _changeFontSize(double size) {
    setState(() {
      _currentFontSize = size;
      _currentTextStyle = _currentTextStyle.copyWith(fontSize: size);
    });
  }

  String _convertTextToHtml(String text, TextStyle style) {
    final StringBuffer htmlBuffer = StringBuffer();

    if (style.fontWeight == FontWeight.bold) {
      htmlBuffer.write('<b>$text</b>');
    } else if (style.fontStyle == FontStyle.italic) {
      htmlBuffer.write('<i>$text</i>');
    } else if (style.decoration == TextDecoration.underline) {
      htmlBuffer.write('<u>$text</u>');
    } else {
      htmlBuffer.write(text);
    }

    final colorHex = style.color?.value.toRadixString(16).padLeft(6, '0');
    final fontSize = style.fontSize != null ? 'font-size: ${style.fontSize}px;' : '';

    return '<span style="color: #$colorHex; $fontSize">${htmlBuffer.toString()}</span>';
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
            onPressed: _toggleBold,
          ),
          IconButton(
            icon: Icon(Icons.format_underline),
            onPressed: _toggleUnderline,
          ),
          IconButton(
            icon: Icon(Icons.format_italic),
            onPressed: _toggleItalic,
          ),
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: _changeTextColor,
          ),
          PopupMenuButton<double>(
            icon: Icon(Icons.format_size),
            onSelected: _changeFontSize,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 14.0,
                child: Text('14'),
              ),
              PopupMenuItem(
                value: 16.0,
                child: Text('16'),
              ),
              PopupMenuItem(
                value: 18.0,
                child: Text('18'),
              ),
              PopupMenuItem(
                value: 20.0,
                child: Text('20'),
              ),
              PopupMenuItem(
                value: 24.0,
                child: Text('24'),
              ),
            ],
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
                  style: _currentTextStyle,
                  decoration: InputDecoration(
                    hintText: 'Enter your note here...',
                    border: InputBorder.none,
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
          onPressed: createNote,
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
