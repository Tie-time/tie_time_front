import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tie_time_front/providers/settings.provider.dart';
import 'package:tie_time_front/widgets/sections/max-task.section.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Configuration'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MaxTaskSection(
                    value: settingsProvider.settings.maxTasks,
                    onValueChanged: (value) {
                      settingsProvider.updateMaxTasks(value);
                    },
                  ),
                  // PassionsSettingsList(
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
