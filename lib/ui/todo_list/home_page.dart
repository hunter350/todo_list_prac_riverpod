import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../edit_todo/edit_todo.dart';
import 'todo_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  //final selectedTab = HomeTab.todos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final selectedTab = ref.watch(appManagerProvider.select((p) => p.selectedTab1));
    return Scaffold(
      body: TodoList(),
    );

    // return Scaffold(
    //   body: IndexedStack(
    //     index : inModel.stackIndex,
    //     children : [
    //       TodoList(),
    //       EditTodo()
    //     ] /* End IndexedStack children. */
    // ),
    // );
  }
}
