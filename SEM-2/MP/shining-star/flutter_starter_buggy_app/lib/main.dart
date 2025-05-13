
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buggy Notes App',
      home: NotesScreen(),
    );
  }
}

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<String> notes = []; // TODO: Replace with NoteModel later

  void addNote(String note) {
    setState(() {
      notes.add(note);// BUG: This does not trigger UI update
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(notes[index]));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote("Sample Note"); // TODO: Replace with note input dialog
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
