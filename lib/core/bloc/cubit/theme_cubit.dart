import 'package:crypto_realtime/core/abstract/base_cubit.dart';
import 'package:crypto_realtime/core/bloc/cubit/theme_state.dart';

class ThemeCubit extends BaseCubit<ThemeState> {
  ThemeCubit() : super(ThemeState());

  void toggleTheme(
    ThemeState state,
  ) {
    final newStatus = state.isLight ? ThemeStatus.dark : ThemeStatus.light;
    emit(state.copyWith(status: newStatus));
  }
}
