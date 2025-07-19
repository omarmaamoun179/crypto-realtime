import 'dart:async';

import 'package:crypto_realtime/core/const/app_images.dart';
import 'package:crypto_realtime/core/utils/media_query_values.dart';
import 'package:crypto_realtime/features/home_crypto/presentation/widgets/custom_appbar.dart';
import 'package:crypto_realtime/features/home_crypto/presentation/widgets/home_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/cubit/theme_cubit.dart';
import '../../../../core/bloc/cubit/theme_state.dart';
import '../../../../core/utils/connection_checker.dart';
import '../../../../shared_widgets/dialog/no_connections_dialog.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../cubit/home_crypto_cubit.dart';
import '../cubit/home_crypto_state.dart';
import '../widgets/custom_divider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription _connectionSubscription;

  @override
  void initState() {
    super.initState();
    _connectionSubscription =
        ConnectionChecker().connectionStream.listen((result) {
      if (!result.newState) {
        showNoConnectionDialog(context);
      }
    });
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var themeCubit = context.read<ThemeCubit>();
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: CustomAppBar(onChanged: (value) {
          context.read<HomeCryptoCubit>().search(value);
        }),
        body: BlocBuilder<HomeCryptoCubit, HomeCryptoState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                  child: CircularProgressIndicator(
                color: themeCubit.state.status == ThemeStatus.dark
                    ? Colors.white
                    : Colors.black,
              ));
            }
            return RefreshIndicator(
              onRefresh: () async {
                if (ConnectionChecker().hasConnection) {
                  context.read<HomeCryptoCubit>().refresh();
                } else {
                  showNoConnectionDialog(context);
                }
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const HomeBlocListener(),
                    SizedBox(height: context.height * 0.08),
                    SizedBox(
                      width: context.width,
                      height: context.height * 0.05,
                      child: _buildTitles(),
                    ),
                    const CustomDivider(),
                    state.filteredCoins == null ||
                            state.filteredCoins?.isEmpty == true
                        ? _buildNoText(context)
                        : ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Column(
                                children: [
                                  CustomDivider(),
                                  SizedBox(height: 16.0),
                                ],
                              );
                            },
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.filteredCoins?.length ?? 0,
                            itemBuilder: (context, index) {
                              final coin = state.filteredCoins![index];

                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildCurrencyNameAndLogo(
                                          name: coin.instId ?? '',
                                          logo: AppImages.getImageForCurrency(
                                              coin.instId ?? '')),
                                      _buildCurrencyPrice(
                                          price: coin.last ?? '0.0',
                                          initialPrices:
                                              coin.open24h?.toString() ?? '',
                                          currentPrice: state
                                              .currentPrice?[coin.instId]
                                              ?.toString())
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                    SizedBox(height: context.height * 0.1)
                  ],
                ),
              ),
            );
          },
        ));
  }

  Center _buildNoText(BuildContext context) {
    return const Center(child: SubtitleText(text: 'No results found'));
  }

  Widget _buildTitles() {
    return Stack(
      children: [
        Positioned(
            top: 0, left: 0, child: _buildCurrencyName(name: "Top Currency")),
        Positioned(top: 0, right: 0, child: _buildCurrencyName(name: "Change")),
      ],
    );
  }

  Widget _buildCurrencyNameAndLogo({
    required String name,
    required String logo,
  }) {
    return Row(
      children: [
        logo.isNotEmpty
            ? Image.asset(
                logo,
                width: 24.0,
                height: 24.0,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.error, color: Colors.red),
        const SizedBox(width: 8),
        SubtitleText.medium(
          text: name,
          isBold: true,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCurrencyName({required String name}) {
    return SubtitleText(text: name, textAlign: TextAlign.center, isBold: true);
  }

  Widget _buildCurrencyPrice(
      {required String price,
      required String? initialPrices,
      required String? currentPrice}) {
    double priceValue = double.tryParse(price) ?? 0.0;
    String formattedPrice = priceValue.toStringAsFixed(2);
    return Column(
      children: [
        SubtitleText(
            text: '$formattedPrice\$',
            textAlign: TextAlign.center,
            isBold: true),
        const SizedBox(height: 8.0),
        _buildCurrencyChange(
            initialPrices: initialPrices ?? '', currentPrice: currentPrice),
      ],
    );
  }

  Widget _buildCurrencyChange(
      {required String initialPrices, String? currentPrice}) {
    double lastPrice = double.tryParse(initialPrices) ?? 0.0;
    double open24hPrice = double.tryParse(currentPrice ?? '') ?? 0.0;

    double priceChange = lastPrice - open24hPrice;
    double percentageChange = (priceChange / open24hPrice) * 100;

    Color changeColor = priceChange > 0
        ? Colors.green
        : priceChange < 0
            ? Colors.red
            : Colors.grey;

    String changeText =
        '${priceChange.toStringAsFixed(2)} (${percentageChange.toStringAsFixed(2)}%)';

    return SubtitleText.small(
      color: changeColor,
      text: changeText,
      textAlign: TextAlign.center,
      isBold: true,
    );
  }
}
