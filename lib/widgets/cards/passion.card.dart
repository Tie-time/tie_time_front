import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    print(_passion.iconPath);
    print(_passion.iconUrl);
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
                color:
                    _passion.isChecked ? Color(0xFFF8A980) : Color(0xFFFEF2EC),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(8),
              child: Center(
                child: SvgPicture.network(
                  _passion.iconUrl,
                  width: 32,
                  height: 32,
                ),
                // child: Text(
                //   _passion.label,
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //   ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
