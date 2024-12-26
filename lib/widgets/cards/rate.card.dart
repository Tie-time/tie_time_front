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
      child: Card.filled(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Color(0xFFEEECD8),
        child: AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(children: [
              Text(
                _rate.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100, // Taille fixe pour le cercle
                        height: 100,
                        child: CircularProgressIndicator(
                          value: 3 / 5,
                          strokeWidth: 16,
                          strokeAlign: -1,
                          semanticsValue: '3/5',
                          strokeCap: StrokeCap.round,
                          backgroundColor: Color(0xFFBFBEBE),
                          color: Color(0xFF2D3A3E),
                        ),
                      ),
                      Text(
                        '3/5',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3A3E),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
