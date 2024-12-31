import 'package:flutter/material.dart';
import 'package:tie_time_front/models/rate.model.dart';
import 'package:tie_time_front/widgets/cards/flip.card.dart';
import 'package:numberpicker/numberpicker.dart';

class RateCard extends StatefulWidget {
  final Rate rate;
  final Function(Rate) onRateScoreChange;

  const RateCard(
      {super.key, required this.rate, required this.onRateScoreChange});

  @override
  State<RateCard> createState() => _RateCardState();
}

class _RateCardState extends State<RateCard>
    with SingleTickerProviderStateMixin {
  late Rate _rate;
  late int _currentScore;

  @override
  void initState() {
    super.initState();
    _rate = widget.rate;
    _currentScore = _rate.score;
  }

  @override
  void didUpdateWidget(RateCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rate != oldWidget.rate) {
      print('RateCard: didUpdateWidget');
      print('Old rate: ${oldWidget.rate.score}');
      print('New rate: ${widget.rate.score}');
      setState(() {
        _rate = widget.rate;
      });
    }
  }

  void _updateScore(int newScore) {
    // Update title
    final rateUpdated = _rate.copyWith(score: newScore);
    widget.onRateScoreChange(rateUpdated);
    // Navigator.of(context).pop();
  }

  void _updateCurrentScore(int newScore) {
    // Update title

    // Navigator.of(context).pop();
  }

  void _toggleEditing() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
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
                      value: _currentScore,
                      minValue: 0,
                      maxValue: 5,
                      step: 1,
                      axis: Axis.horizontal,
                      onChanged: (value) {
                        setModalState(() {
                          _currentScore = value;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, _currentScore);
                      },
                      child: Text('Valider'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    ).then((value) {
      if (value != null) {
        _updateScore(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _toggleEditing,
      child: FlipCard(
        front: Card.filled(
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
                            value: _rate.score / _rate.outOf,
                            strokeWidth: 16,
                            strokeAlign: -1,
                            strokeCap: StrokeCap.round,
                            backgroundColor: Color(0xFFBFBEBE),
                            color: Color(0xFF2D3A3E),
                          ),
                        ),
                        Text(
                          _rate.id != null
                              ? '${_rate.score}/${_rate.outOf}'
                              : '-/${_rate.outOf}',
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
        ), // Votre widget face avant,
        back: Card.filled(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Color(0xFFEEECD8),
          child: AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _rate.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
