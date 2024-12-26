import 'package:flutter/material.dart';
import 'package:tie_time_front/models/rate.model.dart';

class RateCard extends StatefulWidget {
  final Rate rate;

  const RateCard({super.key, required this.rate});

  @override
  State<RateCard> createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> {
  late Rate _rate;

  @override
  void initState() {
    super.initState();
    _rate = widget.rate;
  }

  @override
  void didUpdateWidget(RateCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rate != oldWidget.rate) {
      setState(() {
        _rate = widget.rate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: 78,
        height: 78,
        child: Card.filled(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: AspectRatio(
            aspectRatio: 1, // Force un ratio 1:1 pour avoir un carré
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFEEECD8),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  _rate.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
