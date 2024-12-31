import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class ScoreModal extends StatefulWidget {
  final int initialScore;

  const ScoreModal({
    super.key,
    required this.initialScore,
  });

  @override
  State<ScoreModal> createState() => _ScoreModalState();
}

class _ScoreModalState extends State<ScoreModal> {
  late int _score;

  @override
  void initState() {
    super.initState();
    _score = widget.initialScore;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Modifier la note',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              NumberPicker(
                value: _score,
                minValue: 0,
                maxValue: 5,
                step: 1,
                axis: Axis.horizontal,
                onChanged: (value) => setState(() => _score = value),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, _score),
                child: Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
