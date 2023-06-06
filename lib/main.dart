import 'package:flutter/material.dart';
import 'package:group_35_todo_app/repos/sql_helper.dart';
import 'package:group_35_todo_app/root/app_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SqlHelper.init();

  runApp(AppRoot());
}
