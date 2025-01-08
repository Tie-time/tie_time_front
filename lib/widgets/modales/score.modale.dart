import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class ScoreModal extends StatefulWidget {
  final int initialScore;
  final String title;
  final int minScore;
  final int maxScore;

  const ScoreModal({
    super.key,
    required this.initialScore,
    required this.title,
    required this.minScore,
    required this.maxScore,
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
                widget.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              NumberPicker(
                value: _score,
                infiniteLoop: true,
                minValue: widget.minScore,
                maxValue: widget.maxScore,
                step: 1,
                axis: Axis.horizontal,
                onChanged: (value) => setState(() => _score = value),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFF2D3A3E)),
                ),
                textStyle: TextStyle(fontSize: 20, color: Color(0xFF2D3A3E)),
                selectedTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7984)),
              ),
              SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.pop(context, _score),
                child: const Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
