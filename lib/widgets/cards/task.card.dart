import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final String title;

  const TaskCard({super.key, required this.title});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isChecked = false;

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
    // send request to update task at parent level
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCheckbox,
      child: Card.filled(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: _isChecked ? Color(0xFFE2F9FF) : Color(0xFFF1F1F1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                child: Container(
                  width: 24.0, // Largeur de la zone tactile
                  height: 24.0, // Hauteur de la zone tactile
                  alignment: Alignment.center,
                  child: Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      _toggleCheckbox();
                    },
                    side: BorderSide(
                      color: _isChecked ? Color(0xFF2E7984) : Color(0xFFBFBEBE),
                      width: 2.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 32.0),
              Text(widget.title),
            ],
          ),
        ),
      ),
    );
  }
}
