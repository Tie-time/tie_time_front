import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tie_time_front/config/environnement.config.dart';
import 'package:tie_time_front/providers/passions-list.provider.dart';
import 'package:tie_time_front/services/api.service.dart';
import 'package:tie_time_front/services/messages.service.dart';
import 'package:tie_time_front/services/passion.service.dart';
import 'package:tie_time_front/widgets/cards/passion.card.dart';

class PassionsList extends StatefulWidget {
  final ValueNotifier<DateTime> currentDateNotifier;

  const PassionsList({super.key, required this.currentDateNotifier});

  @override
  State<PassionsList> createState() => _PassionsListState();
}

class _PassionsListState extends State<PassionsList> {
  late PassionProvider _passionProvider;
  late Future<void> _loadPassionFuture;

  @override
  void initState() {
    super.initState();
    _passionProvider = PassionProvider(
        PassionService(apiService: ApiService(baseUrl: Environnement.apiUrl)));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _passionProvider.setContext(context);
    });
    _loadPassionFuture =
        _passionProvider.loadPassions(widget.currentDateNotifier.value);
    widget.currentDateNotifier.addListener(() {
      _loadPassionFuture =
          _passionProvider.loadPassions(widget.currentDateNotifier.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _passionProvider,
      child: Consumer<PassionProvider>(
        builder: (context, passionProvider, child) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Passions',
                  style: const TextStyle(
                    fontSize: 24.0, // Taille de la police pour le titre
                    fontWeight: FontWeight.bold, // Mettre le texte en gras
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              FutureBuilder<void>(
                future: _loadPassionFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      MessageService.showErrorMessage(
                          context, snapshot.error.toString());
                    });
                    return Container();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: passionProvider.passions.length,
                      itemBuilder: (context, index) {
                        final passion = passionProvider.passions[index];
                        return Row(
                          children: [
                            PassionCard(
                                passion: passion,
                                onCheckPassion:
                                    passionProvider.handleCheckPassion),
                            const SizedBox(height: 16.0),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
