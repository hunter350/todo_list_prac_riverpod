import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../logic/todos_api/models/todo.dart';
import '../edit_todo/edit_todo.dart';
import 'app.dart';
import 'todo_list_tile.dart';
import 'todos_overview_filter_button.dart';
import 'todos_overview_options_button.dart';
import 'todos_view_filter.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TodosOverviewView();
  }
}

class TodosOverviewView extends ConsumerWidget {
  const TodosOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(appManagerProvider.select((p) => p.getTodos()));
    final filter =
        ref.watch(appManagerProvider.select((p) => p.getFilterTodos()));
    //   print(filter);
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoList'),
        actions: const [
          TodosOverviewFilterButton(),
          TodosOverviewOptionsButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('homeView_addTodo_floatingActionButton'),
        onPressed: () {
          ref.watch(appManagerProvider.select((p) => p.isNewTodo1(true)));
          Navigator.of(context).push(
            EditTodo.route(initialTodo: null, isNewTodo1: true),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: CupertinoScrollbar(
          child: StreamBuilder<List<Todo>>(
        stream: todos,
        builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
          //  final listTodos ;
          // if (filter == TodosViewFilter.activeOnly){
          //   listTodos = snapshot.data!.where((todo) => !todo.isCompleted);
          // }else if (filter == TodosViewFilter.completedOnly){
          //   listTodos = snapshot.data!.where((todo) => todo.isCompleted);
          // }else{
          //   listTodos = snapshot.data!;
          // }
          //print(snapshot.hasData);
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Списк пуст, создайте первую задачу',
                style: Theme.of(context).textTheme.caption,
              ),
            );
          } else {
            final listTodos;
            if (filter == TodosViewFilter.activeOnly) {
              listTodos = snapshot.data!.where((todo) => !todo.isCompleted);
            } else if (filter == TodosViewFilter.completedOnly) {
              listTodos = snapshot.data!.where((todo) => todo.isCompleted);
            } else {
              listTodos = snapshot.data!;
            }
            return ListView(children: [
              for (final todo in listTodos)
                TodoListTile(
                  todo: todo,
                  onToggleCompleted: (isCompleted) {
                    ref.watch(appManagerProvider
                        .select((p) => p.isCompleted1(todo, isCompleted)));
                    print(todo);
                  },
                  onDismissed: (_) {
                    ref.watch(appManagerProvider
                        .select((p) => p.deleteTodo(todo.id)));
                  },
                  onTap: () {
                    ref.watch(
                        appManagerProvider.select((p) => p.isNewTodo1(false)));
                    Navigator.of(context).push(
                      EditTodo.route(initialTodo: todo, isNewTodo1: false),
                    );
                  },
                ),
            ]);
          }
        },
      )),
    );
  }
}
