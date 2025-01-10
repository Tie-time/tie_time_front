import 'package:flutter/material.dart';
import 'package:tie_time_front/widgets/buttons/rounded.button.dart';
import 'package:tie_time_front/widgets/sections/section.layout.dart';

class MaxTaskSection extends StatelessWidget {
  const MaxTaskSection({
    super.key,
    required this.value,
    required this.onValueChanged,
  });

  final int value;
  final ValueChanged<int> onValueChanged;

  static const int _maxValue = 10;
  static const int _minValue = 1;

  void _increment() {
    if (value < _maxValue) {
      onValueChanged(value + 1);
    }
  }

  void _decrement() {
    if (value > _minValue) {
      onValueChanged(value - 1);
    }
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
              value.toString(),
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
