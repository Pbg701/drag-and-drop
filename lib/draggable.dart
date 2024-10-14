import 'package:flutter/material.dart';

/// Home screen with draggable icons
class DragAndDropScreen extends StatefulWidget {
  const DragAndDropScreen({super.key});

  @override
  State createState() => _DragAndDropScreenState();
}

class _DragAndDropScreenState extends State<DragAndDropScreen> {
  /// List of icons that will be draggable
  final List<IconData> icons = [
    Icons.star,
    Icons.favorite,
    Icons.cake,
    Icons.lightbulb,
    Icons.alarm,
  ];

  /// Position of each icon in the slots
  List<int> slots = [0, 1, 2, 3, 4];

  /// Current icon being dragged
  int? draggingIndex;

  /// Handles when an icon is dragged
  void _onDragUpdate(DragUpdateDetails details, int index) {
    setState(() {
      draggingIndex = index;
    });
  }

  /// Handles when an icon is released after dragging
  void _onDragEnd(DraggableDetails details, int index) {
    setState(() {
      draggingIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Drag Icons Between Slots'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the slots with icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(icons.length, (index) {
                return _buildSlot(index);
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the slot for the draggable icon
  Widget _buildSlot(int index) {
    return DragTarget<int>(
      onAccept: (draggedIndex) {
        setState(() {
          int temp = slots[index];
          slots[index] = slots[draggedIndex];
          slots[draggedIndex] = temp;
        });
      },
      builder: (context, candidateData, rejectedData) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Container(
            key: ValueKey<int>(slots[index]),
            width: 70,
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Draggable<int>(
              data: index,
              feedback: Icon(icons[slots[index]], size: 40, color: Colors.blue),
              childWhenDragging: Container(),
              onDragEnd: (details) => _onDragEnd(details, index),
              onDragUpdate: (details) => _onDragUpdate(details, index),
              child: Icon(icons[slots[index]], size: 40),
            ),
          ),
        );
      },
    );
  }
}
