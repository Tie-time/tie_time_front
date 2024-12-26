import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tie_time_front/config/environnement.config.dart';
import 'package:tie_time_front/providers/rates-list.provider.dart';
import 'package:tie_time_front/services/api.service.dart';
import 'package:tie_time_front/services/messages.service.dart';
import 'package:tie_time_front/services/rate.service.dart';
import 'package:tie_time_front/widgets/cards/rate.card.dart';

class RatesList extends StatefulWidget {
  final ValueNotifier<DateTime> currentDateNotifier;

  const RatesList({super.key, required this.currentDateNotifier});

  @override
  State<RatesList> createState() => _RatesListState();
}

class _RatesListState extends State<RatesList> {
  late RateProvider _rateProvider;
  late Future<void> _loadRateFuture;

  @override
  void initState() {
    super.initState();
    _rateProvider = RateProvider(
        RateService(apiService: ApiService(baseUrl: Environnement.apiUrl)));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _rateProvider.setContext(context);
    });
    _loadRateFuture = _rateProvider.loadRates(widget.currentDateNotifier.value);
    widget.currentDateNotifier.addListener(() {
      _loadRateFuture =
          _rateProvider.loadRates(widget.currentDateNotifier.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _rateProvider,
      child: Consumer<RateProvider>(
        builder: (context, rateProvider, child) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rates',
                  style: const TextStyle(
                    fontSize: 24.0, // Taille de la police pour le titre
                    fontWeight: FontWeight.bold, // Mettre le texte en gras
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                child: FutureBuilder<void>(
                  future: _loadRateFuture,
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
                        itemCount: rateProvider.rates.length,
                        itemBuilder: (context, index) {
                          final rate = rateProvider.rates[index];
                          return Row(
                            children: [
                              RateCard(
                                rate: rate,
                              ),
                              const SizedBox(width: 16.0),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
