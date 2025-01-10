import 'package:flutter/material.dart';
import 'package:tie_time_front/widgets/buttons/rounded.button.dart';
import 'package:tie_time_front/widgets/sections/section.layout.dart';

class MaxTaskSection extends StatefulWidget {
  const MaxTaskSection({
    super.key,
  });
  @override
  State<MaxTaskSection> createState() => _MaxTaskSectionState();
}

class _MaxTaskSectionState extends State<MaxTaskSection> {
  static const int _maxValue = 10;
  static const int _minValue = 1;
  int _value = 5; // valeur par défaut

  void _increment() {
    setState(() {
      if (_value < _maxValue) {
        _value++;
      }
    });
  }

  void _decrement() {
    setState(() {
      if (_value > _minValue) {
        _value--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      title: 'Régler le nombre de tâches maximum par jour (max 10)',
      child: SizedBox(
        width: 230,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RoundedButton(
              title: '-',
              onPressed: _decrement,
            ),
            Text(
              _value.toString(),
              style: const TextStyle(
                fontFamily: "Londrina",
                fontSize: 56,
                fontWeight: FontWeight.w400,
                color: Color(0xFF2E7984),
              ),
            ),
            RoundedButton(
              title: '+',
              onPressed: _increment,
            ),
          ],
        ),
      ),
    );
  }
}
