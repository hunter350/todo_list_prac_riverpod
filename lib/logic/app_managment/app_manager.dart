import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../ui/todo_list/todos_view_filter.dart';
import '../todos_api/models/todo.dart';
import '../todos_repository/todos_repository.dart';

class AppManager with ChangeNotifier {
  final TodosRepository todosRepository;

  AppManager({required this.todosRepository});

  bool isNewTodo2 = true;
  TodosViewFilter filter = TodosViewFilter.all;

//  HomeTab selectedTab1 = HomeTab.todos;
// //bool isCompleted = false;

  Stream<List<Todo>> getTodos() {
    return todosRepository.getTodos();
  }

  void saveTodo(Todo todo) {
    todosRepository.saveTodo(todo);
    notifyListeners();
  }

  void deleteTodo(String id) {
    todosRepository.deleteTodo(id);
    notifyListeners();
  }

  void isCompleted1(Todo todo, bool isCompleted) {
    todo.isCompleted = isCompleted;
    saveTodo(todo);
    notifyListeners();
  }

  // void selectedTabManage(HomeTab homeTab) { //This is only example like block
  //   this.selectedTab1 = homeTab;
  //   notifyListeners();
  // }
  //
  void isNewTodo1(bool isNewTodo) {
    isNewTodo2 = isNewTodo;
    notifyListeners();
  }
  // Future<List<Todo>> getFilterTodos1()  async {
  //   final todos = getTodos();
  //   if (filter == TodosViewFilter.activeOnly) {
  //     final todos1 =  todos.forEach((element) => element.where((todo) => !todo.isCompleted)) as List<Todo>;
  //
  //   } else if (filter == TodosViewFilter.completedOnly) {
  //     return todos.forEach((element) =>
  //         element.where((todo) => todo.isCompleted)) as List<Todo>;
  //   }  else {
  //     final todos1 = todos as  List<Todo>;
  //         return todos1;
  //       }
  //
  // }
  void filterTodos(TodosViewFilter filter1) {
    if (filter1 == TodosViewFilter.all) {
      filter = TodosViewFilter.all;
    } else if (filter1 == TodosViewFilter.activeOnly) {
      filter = TodosViewFilter.activeOnly;
    } else if (filter1 == TodosViewFilter.completedOnly) {
      filter = TodosViewFilter.completedOnly;
    }
    notifyListeners();
  }

  TodosViewFilter getFilterTodos() {
    return filter;
  }

  // Stream<List<Todo>> getFilterTodos1(){
  //   final todos1 = getTodos();
  //   if (filter == TodosViewFilter.activeOnly) {
  //     //return todos1.where((element) => element.where((todo) => !todo.isCompleted)) as Stream<List<Todo>>;
  //
  //   } else if (filter == TodosViewFilter.completedOnly) {
  //    // return todos1.where((todo) => todo.where((todo) => todo.isCompleted));
  //     //return todos1.forEach((element) => element.where((todo) => todo.isCompleted)) as Stream<List<Todo>>;
  //   } else {
  //     return todos1;
  //   }
  // }
// Future<List<Todo>> getFilterTodos1(){
//   final todos1 = getTodos();
//   if (filter == TodosViewFilter.activeOnly) {
//     return todos1.forEach((element) => element.where((todo) => !todo.isCompleted)) as Future<List<Todo>>;
//   } else if (filter == TodosViewFilter.completedOnly) {
//    // return todos1.where((todo) => todo.where((todo) => todo.isCompleted));
//     return todos1.forEach((element) => element.where((todo) => todo.isCompleted)) as Future<List<Todo>>;
//   } else {
//     return todos1 as Future<List<Todo>>;
//   }
// }
}
