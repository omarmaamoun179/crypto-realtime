import 'package:crypto_realtime/core/bloc/cubit/theme_cubit.dart';
import 'package:crypto_realtime/core/bloc/cubit/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.onChanged});
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    var themeCubit = context.read<ThemeCubit>();
    var theme = Theme.of(context);
    return AppBar(
      title: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: themeCubit.state.status == ThemeStatus.dark
              ? const Color(0xff151518)
              : Colors.black12,
          filled: true,
          hintText: 'Search',
          border: _outLineBorder(context),
          enabledBorder: _outLineBorder(context),
          focusedBorder: _outLineBorder(context),
          prefixIcon: const Icon(Icons.search),
          hintStyle: TextStyle(color: theme.hintColor),
        ),
        style: TextStyle(color: theme.textTheme.bodyMedium?.color),
      ),
      centerTitle: true,
      actions: [
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return IconButton(
              icon: Icon(
                themeCubit.state.status == ThemeStatus.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                context
                    .read<ThemeCubit>()
                    .toggleTheme(context.read<ThemeCubit>().state);
              },
            );
          },
        ),
      ],
    );
  }

  OutlineInputBorder _outLineBorder(BuildContext context) {
    var themeCubit = context.read<ThemeCubit>();
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(
          color: themeCubit.state.status == ThemeStatus.dark
              ? Colors.white70
              : Colors.black54,
          style: BorderStyle.solid,
          width: 1.0),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
