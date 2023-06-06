import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_35_todo_app/models/todo_model.dart';
import 'package:group_35_todo_app/repos/sql_helper.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  static TodoCubit get(context) => BlocProvider.of(context);

  List<TodoModel> items = [];
  List<TodoModel> itemsCompleted = [];
  List<TodoModel> itemsNotCompleted = [];

  makeTodoCompleted(TodoModel item) {
    item.status = true;
    SqlHelper.editTodo(item).then((value) {
      emit(ChangeTodoToCompletedState());
      getItems();
    });
  }

  makeTodoNotCompleted(TodoModel item) {
    item.status = false;
    SqlHelper.editTodo(item).then((value) {
      emit(ChangeTodoToCompletedState());
      getItems();
    });
  }

  getItems() async {
    emit(GetItemsLoading());

    await SqlHelper.getAllTodos().then((value) {
      items = value;
      itemsCompleted = [];
      itemsNotCompleted = [];

      for (var element in items) {
        if (element.status!) {
          itemsCompleted.add(element);
        } else {
          itemsNotCompleted.add(element);
        }
      }

      emit(GetItemsSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetItemsError());
    });
  }

  createTodo(TodoModel item) async {
    emit(CreateTodoLoading());
    await SqlHelper.insertTodo(item).then((value) {
      emit(CreateTodoSuccess());
      getItems();
    }).catchError((error) {
      print(error.toString());
      emit(CreateTodoError());
    });
  }
}
