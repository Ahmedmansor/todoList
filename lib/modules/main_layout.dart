import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_35_todo_app/cubits/main_cubit/main_cubit.dart';
import 'package:group_35_todo_app/modules/create_todo_screen.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  Route _buildRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          CreateTodoScreen(),
      transitionDuration: const Duration(seconds: 1),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = const Offset(0.0, 0.0);

        var tween = Tween(begin: begin, end: end);

        var anim = animation.drive(tween);

        return SlideTransition(
          position: anim,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: MainCubit.get(context).screens[MainCubit.get(context).index],
          appBar: _buildAppBar(),
          bottomNavigationBar: _buildBottomNav(context),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, _buildRoute());
            },
            backgroundColor: Colors.deepOrange,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: const Icon(
              Icons.add_task,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  _buildBottomNav(context) {
    return BottomNavigationBar(
      currentIndex: MainCubit.get(context).index,
      onTap: (value) {
        MainCubit.get(context).changeScreen(value);
      },
      selectedItemColor: Colors.deepOrange,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.check,
          ),
          label: "Completed",
        )
      ],
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text("Todo App"),
      actions: [
        BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return Switch(
              value: MainCubit.get(context).isDark,
              onChanged: (value) {
                MainCubit.get(context).changeTheme();
              },
            );
          },
        )
      ],
    );
  }
}
