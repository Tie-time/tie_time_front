import 'package:flutter/material.dart';
import 'package:tie_time_front/models/passion.model.dart';

class PassionCard extends StatefulWidget {
  final Passion passion;
  final Function(Passion) onCheckPassion;

  const PassionCard(
      {super.key, required this.passion, required this.onCheckPassion});

  @override
  State<PassionCard> createState() => _PassionCardState();
}

class _PassionCardState extends State<PassionCard> {
  late Passion _passion;

  @override
  void initState() {
    super.initState();
    _passion = widget.passion;
  }

  @override
  void didUpdateWidget(PassionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.passion != oldWidget.passion) {
      setState(() {
        _passion = widget.passion;
      });
    }
  }

  void _onCheckPassion() {
    widget.onCheckPassion(_passion);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onCheckPassion,
      child: Card.filled(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: _passion.isChecked ? Color(0xFFE2F9FF) : Color(0xFFF1F1F1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 32.0),
              SizedBox(
                width: 50.0, // Largeur fixe pour le TextField
                child: Text(_passion.label,
                    style: TextStyle(
                        color: _passion.isChecked
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
