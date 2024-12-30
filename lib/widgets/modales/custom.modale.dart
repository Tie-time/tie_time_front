import 'package:flutter/material.dart';

class CustomModal extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;

  const CustomModal({
    Key? key,
    required this.title,
    required this.content,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: actions ??
          [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer'),
            ),
          ],
    );
  }
}
