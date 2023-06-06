import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_35_todo_app/cubits/todo_cubit/todo_cubit.dart';

import 'view_todo_screen.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
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
          return TodoCubit.get(context).itemsCompleted.isEmpty
              ? _buildNoItems()
              : _buildListView();
        },
      ),
    );
  }

  _buildListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        var item = TodoCubit.get(context).itemsCompleted[index];
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
                TodoCubit.get(context).makeTodoNotCompleted(item);
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
      itemCount: TodoCubit.get(context).itemsCompleted.length,
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
