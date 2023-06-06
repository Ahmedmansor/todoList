import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_35_todo_app/cubits/todo_cubit/todo_cubit.dart';
import 'package:group_35_todo_app/models/todo_model.dart';

class ViewTodoScreen extends StatelessWidget {
  ViewTodoScreen({super.key, required this.item});

  TodoModel item;

  DateTime? dateTime;

  var dateTimeController = TextEditingController();
  var titleController = TextEditingController();
  var bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dateTimeController.text = item.dateTime!;
    titleController.text = item.title!;
    bodyController.text = item.body!;

    return Scaffold(
      appBar: AppBar(
        title: Text("${item.title}"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check))
        ],
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
