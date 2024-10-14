import 'package:draggable_ui/draggable.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const DragAndDropApp());
}
/// Main application widget
class DragAndDropApp extends StatelessWidget {
  const DragAndDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drag and Drop Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DragAndDropScreen(),
    );
  }
}

