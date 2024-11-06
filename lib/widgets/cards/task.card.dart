import 'package:flutter/material.dart';
import 'package:tie_time_front/models/task.model.dart';

class TaskCard extends StatefulWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isEditing = false;
  late Task _task;

  @override
  void initState() {
    super.initState();
    _task = widget.task;
  }

  void _toggleCheckbox() {
    setState(() {
      _task = Task(
        id: _task.id,
        title: _task.title,
        isChecked: !_task.isChecked,
        date: _task.date,
        order: _task.order,
      );
    });
    // send request to update task at parent level
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _updateTitle(String newTitle) {
    if (newTitle.isEmpty) {
      setState(() {
        _isEditing = false;
      });
      return;
    }

    setState(() {
      _task = Task(
        id: _task.id,
        title: newTitle,
        isChecked: _task.isChecked,
        date: _task.date,
        order: _task.order,
      );
      _isEditing = false;
    });
    // send request to update title at parent level
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _toggleEditing,
      onTap: _toggleCheckbox,
      child: Card.filled(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: _task.isChecked ? Color(0xFFE2F9FF) : Color(0xFFF1F1F1),
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
                    value: _task.isChecked,
                    onChanged: (bool? value) {
                      _toggleCheckbox();
                    },
                  ),
                ),
              ),
              SizedBox(width: 32.0),
              SizedBox(
                width: 200.0, // Largeur fixe pour le TextField
                child: _isEditing
                    ? TextField(
                        onSubmitted: _updateTitle,
                        autofocus: true,
                        maxLength: 50,
                        controller: TextEditingController(text: _task.title),
                        // no border and background transparent
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          fillColor: Colors.transparent,
                        ),
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF2D3A3E),
                        ),
                      )
                    : Text(_task.title,
                        style: TextStyle(
                            color: _task.isChecked
                                ? Color(0xFFBFBEBE)
                                : Color(0xFF2D3A3E))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
