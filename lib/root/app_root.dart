import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_35_todo_app/cubits/main_cubit/main_cubit.dart';
import 'package:group_35_todo_app/utils/app_theme.dart';

import '../cubits/todo_cubit/todo_cubit.dart';
import '../modules/main_layout.dart';

class AppRoot extends StatelessWidget {
  AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoCubit()),
        BlocProvider(create: (context) => MainCubit()),
      ],
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const MainLayout(),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: MainCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
          );
        },
      ),
    );
  }
}
