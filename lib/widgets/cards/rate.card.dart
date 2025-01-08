import 'package:flutter/material.dart';
import 'package:tie_time_front/models/rate.model.dart';
import 'package:tie_time_front/widgets/cards/flip.card.dart';
import 'package:tie_time_front/widgets/modales/score.modale.dart';

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

  void _updateScore(int newScore) {
    // Update score
    final rateUpdated = _rate.copyWith(score: newScore);
    widget.onRateScoreChange(rateUpdated);
  }

  void _toggleEditing() async {
    final result = await showModalBottomSheet<int>(
      isScrollControlled: true,
      context: context,
      builder: (_) => ScoreModal(
          initialScore: _rate.score,
          title: _rate.label,
          minScore: 0,
          maxScore: _rate.outOf),
    );

    if (result != null) {
      _updateScore(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      front: GestureDetector(
        onDoubleTap: _toggleEditing,
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
    );
  }
}
