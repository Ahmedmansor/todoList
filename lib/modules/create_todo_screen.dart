import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_35_todo_app/cubits/todo_cubit/todo_cubit.dart';
import 'package:group_35_todo_app/models/todo_model.dart';

class CreateTodoScreen extends StatelessWidget {
  CreateTodoScreen({super.key});

  DateTime? dateTime;

  var dateTimeController = TextEditingController();
  var titleController = TextEditingController();
  var bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Todo"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildDateTime(context),
            const SizedBox(height: 20),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                hintText: "Title",
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines: 5,
              minLines: 5,
              controller: bodyController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                hintText: "Body",
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<TodoCubit, TodoState>(
              listener: (context, state) {
                if (state is CreateTodoSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return state is CreateTodoLoading
                    ? const Center(child: CircularProgressIndicator())
                    : MaterialButton(
                        onPressed: () {
                          TodoModel item = TodoModel(
                            title: titleController.text,
                            body: bodyController.text,
                            dateTime: dateTime.toString(),
                            status: false,
                          );

                          TodoCubit.get(context).createTodo(item);
                        },
                        height: 50,
                        color: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: const Text("Create Todo"),
                      );
              },
            )
          ],
        ),
      ),
    );
  }

  _buildDateTime(context) {
    return TextFormField(
      controller: dateTimeController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () async {
              await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2025))
                  .then((date) {
                print(date);
                if (date == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Choose Date First")));
                } else {
                  dateTime = date;
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then((time) {
                    print(time);
                    if (time == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please Choose Time")));
                    } else {
                      dateTime = dateTime!
                          .copyWith(hour: time.hour, minute: time.minute);
                      dateTimeController.text = dateTime.toString();
                      print(dateTime);
                    }
                  });
                }
              });
            },
            icon: Icon(Icons.calendar_today)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        hintText: "Date Time",
      ),
    );
  }
}
