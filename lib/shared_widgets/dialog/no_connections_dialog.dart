import 'package:crypto_realtime/features/home_crypto/presentation/cubit/home_crypto_cubit.dart';
import 'package:crypto_realtime/shared_widgets/stateless/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/connection_checker.dart';
import '../../features/home_crypto/presentation/pages/default_button.dart';

void showNoConnectionDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const SubtitleText.large(
          text: 'لا يوجد اتصال', textAlign: TextAlign.center),
      content: const SubtitleText(
        text: 'يرجى التحقق من اتصالك بالإنترنت ثم المحاولة مرة أخرى',
        textAlign: TextAlign.center,
      ),
      actions: [
        DefaultButton(
          isExpanded: true,
          backgroundColor: Colors.black,
          onPressed: () {
            final result = ConnectionChecker().hasConnection;
            if (result) {
              Navigator.pop(context);
              context.read<HomeCryptoCubit>().refresh();
            }
          },
          label: 'حاول مرة ثانية',
        ),
      ],
    ),
  );
}
