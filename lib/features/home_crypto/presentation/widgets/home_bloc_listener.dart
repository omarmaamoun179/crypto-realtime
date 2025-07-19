import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared_widgets/snack_bar.dart';
import '../cubit/home_crypto_cubit.dart';
import '../cubit/home_crypto_state.dart';

class HomeBlocListener extends StatelessWidget {
  const HomeBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCryptoCubit, HomeCryptoState>(
      listener: (context, state) {
        if (state.isError) {
          showSnackBar(context,
              message: state.errorMessage ?? 'An error occurred');
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
