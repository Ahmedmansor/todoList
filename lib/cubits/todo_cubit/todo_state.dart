part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

//! -------------------------------------------------
class GetItemsLoading extends TodoState {}

class GetItemsSuccess extends TodoState {}

class GetItemsError extends TodoState {}
//! -------------------------------------------------

//! -------------------------------------------------
class CreateTodoLoading extends TodoState {}

class CreateTodoSuccess extends TodoState {}

class CreateTodoError extends TodoState {}
//! -------------------------------------------------

class ChangeTodoToCompletedState extends TodoState {}
