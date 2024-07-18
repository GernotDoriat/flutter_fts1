// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:docx_to_text/docx_to_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _filePath = 'Keine Datei ausgewählt';

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() async {
        _filePath = result.files.single.path!;
        debugPrint(_filePath);
        /*     final file = File(_filePath);
        final bytes = await file.readAsBytes();
        final text = docxToText(bytes, handleNumbering: true);
        debugPrint(text); */
      });
    } else {
      // Benutzer hat die Datei-Auswahl abgebrochen
      setState(() {
        _filePath = 'Keine Datei ausgewählt';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Datei auswählen'),
            ),
            SizedBox(height: 20),
            Text('Ausgewählte Datei: $_filePath'),
          ],
        ),
      ),
    );
  }
}
