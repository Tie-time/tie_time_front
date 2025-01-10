import 'package:flutter/material.dart';
import 'package:tie_time_front/widgets/buttons/rounded.button.dart';
import 'package:tie_time_front/widgets/sections/max-task.section.dart';
import 'package:tie_time_front/widgets/sections/section.layout.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MaxTaskSection(),

              // PassionsSettingsList(
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
