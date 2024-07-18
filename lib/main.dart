// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:docx_to_text/docx_to_text.dart';

void main() {
  runApp(const MyApp());
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _filePath = 'Keine Datei ausgewählt';
  int _fileSize = 0;
  String _docxText = '';

  Future<void> _pickFile() async {
    // Datei-Auswahl asynchron durchführen
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      String path = result.files.single.path!;
      debugPrint(path);

      // Datei laden und Größe berechnen
      final file = File(path);
      final bytes = await file.readAsBytes();
      int fileSize = bytes.length;

      // Text aus der .docx Datei extrahieren
      final text = await docxToText(bytes, handleNumbering: true);
      debugPrint(text);

      // Zustand synchron aktualisieren
      setState(() {
        _filePath = path;
        _fileSize = fileSize;
        _docxText = text;
      });

      debugPrint(fileSize.toString());
    } else {
      // Benutzer hat die Datei-Auswahl abgebrochen
      setState(() {
        _filePath = 'Keine Datei ausgewählt';
        _fileSize = 0;
        _docxText = '';
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
            SizedBox(height: 10),
            Text('Dateigröße: $_fileSize Bytes'),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                    _docxText.isEmpty ? 'Kein Text extrahiert' : _docxText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
