// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('The App Bar!'),
          centerTitle: true,
          backgroundColor: Colors.red[600]),
      body: Row(
        children: <Widget>[
          Expanded(child: Image.asset('lib/assets/image.jpeg')),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(30.0),
                      color: Colors.cyan,
                      child: Text('1'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(30.0),
                      color: Colors.pinkAccent,
                      child: Text('2'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(30.0),
                      color: Colors.amber,
                      child: Text('3'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // ignore: avoid_print
        onPressed: () => {print('FloatingActionButton')},
        backgroundColor: Colors.red[600],
        child: const Text('click'),
      ),
    );
  }
}
