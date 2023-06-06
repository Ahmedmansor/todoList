import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_35_todo_app/cubits/todo_cubit/todo_cubit.dart';
import 'package:group_35_todo_app/modules/view_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    TodoCubit.get(context).getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return TodoCubit.get(context).itemsNotCompleted.isEmpty
              ? _buildNoItems()
              : _buildListView();
        },
      ),
    );
  }

  _buildListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        var item = TodoCubit.get(context).itemsNotCompleted[index];
        return Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ViewTodoScreen(item: item)));
            },
            trailing: Checkbox(
              value: item.status,
              onChanged: (value) {
                TodoCubit.get(context).makeTodoCompleted(item);
              },
            ),
            leading: Text(item.id.toString()),
            title: Text(item.title!),
            subtitle: Text(
              item.body!,
              maxLines: 2,
            ),
          ),
        );
      },
      itemCount: TodoCubit.get(context).itemsNotCompleted.length,
    );
  }

  _buildNoItems() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.close,
          size: 200,
          color: Colors.deepOrange,
        ),
        Text(
          "No Items Found",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
        ),
      ],
    ));
  }
}
