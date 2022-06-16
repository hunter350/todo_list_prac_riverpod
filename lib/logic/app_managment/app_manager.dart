import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../todos_api/models/todo.dart';
import '../todos_repository/todos_repository.dart';

class AppManager with ChangeNotifier {
 final TodosRepository todosRepository;

  AppManager({required this.todosRepository});

 bool isNewTodo2 = true;
//  HomeTab selectedTab1 = HomeTab.todos;
// //bool isCompleted = false;

  Stream<List<Todo>> getTodos()  {
      return todosRepository.getTodos();
  }

  void saveTodo(Todo todo){
    todosRepository.saveTodo(todo);
    notifyListeners();
  }

 void deleteTodo(String id) {
   todosRepository.deleteTodo(id);
   notifyListeners();
 }

 void isCompleted1(Todo todo, bool isCompleted) {
   todo.isCompleted = isCompleted;
   notifyListeners();
 }

  // void selectedTabManage(HomeTab homeTab) { //This is only example like block
  //   this.selectedTab1 = homeTab;
  //   notifyListeners();
  // }
  //
  void isNewTodo1(bool isNewTodo){
    isNewTodo2 = isNewTodo;
    notifyListeners();
  }
}
