import 'package:flutter/material.dart';
import 'package:todo_list_prac_riverpod/ui/todo_list/todos_view_filter.dart';



class TodosOverviewFilterButton extends StatelessWidget {
  const TodosOverviewFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final l10n = context.l10n;

    // final activeFilter =
    //     context.select((TodosOverviewBloc bloc) => bloc.state.filter);

    return PopupMenuButton<TodosViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      //initialValue: activeFilter,
      //tooltip: l10n.todosOverviewFilterTooltip,
      onSelected: (filter) {
        // context
        //     .read<TodosOverviewBloc>()
        //     .add(TodosOverviewFilterChanged(filter));
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
