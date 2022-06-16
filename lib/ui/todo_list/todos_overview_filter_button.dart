import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_prac_riverpod/ui/todo_list/todos_view_filter.dart';
import 'app.dart';

class TodosOverviewFilterButton extends ConsumerWidget {
  const TodosOverviewFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterManager = ref.watch(appManagerProvider);

    return PopupMenuButton<TodosViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      onSelected: (filter) {
        //ref.watch(appManagerProvider.select((p) => p.filterTodos(filter)));
        filterManager.filterTodos(filter);
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: TodosViewFilter.all,
            child: Text('All'),
          ),
          PopupMenuItem(
            value: TodosViewFilter.activeOnly,
            child: Text('Active'),
          ),
          PopupMenuItem(
            value: TodosViewFilter.completedOnly,
            child: Text('Completed'),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}
