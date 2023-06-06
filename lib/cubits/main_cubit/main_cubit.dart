import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_35_todo_app/modules/completed_screen.dart';
import 'package:group_35_todo_app/modules/home_screen.dart';
import 'package:meta/meta.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  void changeTheme() {
    isDark = !isDark;
    emit(ChangeThemeState());
  }

  int index = 0;
  List<Widget> screens = [const HomeScreen(), const CompletedScreen()];

  void changeScreen(i) {
    index = i;
    emit(ChangeScreenState());
  }
}
