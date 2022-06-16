import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logic/local_storage_todos_api/local_storage_todos_api.dart';
import 'logic/todos_repository/todos_repository.dart';
import 'ui/todo_list/app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final todosApi = LocalStorageTodosApi(
    plugin: await SharedPreferences.getInstance(),
  );

  final todosRepository = TodosRepository(todosApi: todosApi);

  runApp(App(todosRepository: todosRepository));

}