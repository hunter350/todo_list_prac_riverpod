import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../logic/todos_api/models/todo.dart';
import '../edit_todo/edit_todo.dart';
import 'app.dart';
import 'todo_list_tile.dart';
import 'todos_overview_filter_button.dart';
import 'todos_overview_options_button.dart';

class TodoList extends StatelessWidget {
  Widget build(BuildContext inContext) {
    return TodosOverviewView();
  }
}

class TodosOverviewView extends ConsumerWidget {
  TodosOverviewView({Key? key}) : super(key: key);

  // final TodosOverviewState state = TodosOverviewState();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(appManagerProvider.select((p) => p.getTodos()));

    // print(todos.first);

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
          ref.watch(appManagerProvider
              .select((p) => p.isNewTodo1(true)));
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
              //print(snapshot.hasData);
              //if (!snapshot.hasData || snapshot.data!.isEmpty) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'Списк пуст, создайте первую задачу',
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption,
                  ),
                );
                // }else (snapshot.hasData == false && snapshot.hasData) {
              } else {
                // final listTodos = snapshot.data as List
                return ListView(
                  //for (final todo in state.filteredTodos)
                  // for (final todo in todos)

                    children: [
                      for (final todo in snapshot.data!)
                        TodoListTile(
                          todo: todo,
                          onToggleCompleted: (isCompleted) {
                            ref.watch(appManagerProvider
                                .select((p) =>
                                p.isCompleted1(todo, isCompleted)));
                            print(todo);
                            // context.read<TodosOverviewBloc>().add(
                            //   TodosOverviewTodoCompletionToggled(
                            //     todo: todo,
                            //     isCompleted: isCompleted,
                            //   ),
                            // );
                          },
                          onDismissed: (_) {
                            ref.watch(appManagerProvider
                                .select((p) => p.deleteTodo(todo.id)));
                            // context
                            //     .read<TodosOverviewBloc>()
                            //     .add(TodosOverviewTodoDeleted(todo));
                          },
                          onTap: () {
                            ref.watch(appManagerProvider
                                .select((p) => p.isNewTodo1(false)));
                            Navigator.of(context).push(
                              EditTodo.route(initialTodo: todo, isNewTodo1: false),
                            );
                          },
                        ),

                      //for (final todo in state.todos)
                      // for (final todo in todos)
                    ]);
              }
            },
          )),
    );
  }
}

// class TodoList extends StatelessWidget {
//
//
//   /// The build() method.
//   ///
//   /// @param  inContext The BuildContext for this widget.
//   /// @return           A Widget.
//   Widget build(BuildContext inContext) {
//
//     print("## TasksList.build()");
//
//     // Return widget.
//     return ScopedModel<TasksModel>(
//         model : tasksModel,
//         child : ScopedModelDescendant<TasksModel>(
//             builder : (BuildContext inContext, Widget inChild, TasksModel inModel) {
//               return Scaffold(
//                 // Add task.
//                   floatingActionButton : FloatingActionButton(
//                       child : Icon(Icons.add, color : Colors.white),
//                       onPressed : () async {
//                         tasksModel.entityBeingEdited = Task();
//                         tasksModel.setChosenDate(null);
//                         tasksModel.setStackIndex(1);
//                       }
//                   ),
//                   body : ListView.builder(
//                     // Get the first Card out of the shadow.
//                       padding : EdgeInsets.fromLTRB(0, 10, 0, 0),
//                       itemCount : tasksModel.entityList.length,
//                       itemBuilder : (BuildContext inBuildContext, int inIndex) {
//                         Task task = tasksModel.entityList[inIndex];
//                         // Get the date, if any, in a human-readable format.
//                         String sDueDate;
//                         if (task.dueDate != null) {
//                           List dateParts = task.dueDate.split(",");
//                           DateTime dueDate = DateTime(
//                               int.parse(dateParts[0]), int.parse(dateParts[1]), int.parse(dateParts[2])
//                           );
//                           sDueDate = DateFormat.yMMMMd("en_US").format(dueDate.toLocal());
//                         }
//                         // Create the Slidable.
//                         return Slidable(
//                             delegate : SlidableDrawerDelegate(),
//                             actionExtentRatio : .25,
//                             child : ListTile(
//                                 leading : Checkbox(
//                                     value : task.completed == "true" ? true : false,
//                                     onChanged : (inValue) async {
//                                       // Update the completed value for this task and refresh the list.
//                                       task.completed = inValue.toString();
//                                       await TasksDBWorker.db.update(task);
//                                       tasksModel.loadData("tasks", TasksDBWorker.db);
//                                     }
//                                 ),
//                                 title : Text(
//                                     "${task.description}",
//                                     // Dim and strikethrough the text when the task is completed.
//                                     style : task.completed == "true" ?
//                                     TextStyle(color : Theme.of(inContext).disabledColor, decoration : TextDecoration.lineThrough) :
//                                     TextStyle(color : Theme.of(inContext).textTheme.title.color)
//                                 ),
//                                 subtitle : task.dueDate == null ?
//                                 null :
//                                 Text(
//                                     sDueDate,
//                                     // Dim and strikethrough the text when the task is completed.
//                                     style : task.completed == "true" ?
//                                     TextStyle(color : Theme.of(inContext).disabledColor, decoration : TextDecoration.lineThrough)
//                                         :
//                                     TextStyle(color : Theme.of(inContext).textTheme.title.color)
//                                 ),
//                                 // Edit existing task.
//                                 onTap : () async {
//                                   // Can't edit a completed task.
//                                   if (task.completed == "true") { return; }
//                                   // Get the data from the database and send to the edit view.
//                                   tasksModel.entityBeingEdited = await TasksDBWorker.db.get(task.id);
//                                   // Parse out the due date, if any, and set it in the model for display.
//                                   if (tasksModel.entityBeingEdited.dueDate == null) {
//                                     tasksModel.setChosenDate(null);
//                                   } else {
//                                     tasksModel.setChosenDate(sDueDate);
//                                   }
//                                   tasksModel.setStackIndex(1);
//                                 }
//                             ),
//                             secondaryActions : [
//                               IconSlideAction(
//                                   caption : "Delete",
//                                   color : Colors.red,
//                                   icon : Icons.delete,
//                                   onTap : () => _deleteTask(inContext, task)
//                               )
//                             ]
//                         ); /* End Slidable. */
//                       } /* End itemBuilder. */
//                   ) /* End ListView.builder. */
//               ); /* End Scaffold. */
//             } /* End ScopedModelDescendant builder. */
//         ) /* End ScopedModelDescendant. */
//     ); /* End ScopedModel. */
//
//   } /* End build(). */


/// Show a dialog requesting delete confirmation.
///
/// @param  inContext The parent build context.
/// @param  inTask    The task (potentially) being deleted.
/// @return           Future.
///

// Future _deleteTask(BuildContext inContext, Task inTask) async {
//   print("## TasksList._deleteTask(): inTask = $inTask");
//
//   return showDialog(
//       context: inContext,
//       barrierDismissible: false,
//       builder: (BuildContext inAlertContext) {
//         return AlertDialog(
//             title: Text("Delete Task"),
//             content: Text(
//                 "Are you sure you want to delete ${inTask.description}?"),
//             actions: [
//               FlatButton(child: Text("Cancel"),
//                   onPressed: () {
//                     // Just hide dialog.
//                     Navigator.of(inAlertContext).pop();
//                   }
//               ),
//               FlatButton(child: Text("Delete"),
//                   onPressed: () async {
//                     // Delete from database, then hide dialog, show SnackBar, then re-load data for the list.
//                     await TasksDBWorker.db.delete(inTask.id);
//                     Navigator.of(inAlertContext).pop();
//                     Scaffold.of(inContext).showSnackBar(
//                         SnackBar(
//                             backgroundColor: Colors.red,
//                             duration: Duration(seconds: 2),
//                             content: Text("Task deleted")
//                         )
//                     );
//                     // Reload data from database to update list.
//                     tasksModel.loadData("tasks", TasksDBWorker.db);
//                   }
//               )
//             ]
//         );
//       }
//   );
// } /* End _deleteTask(). */
//
//
// } /* End class. */

// class TodosOverviewPage1 extends StatefulWidget {
//   const TodosOverviewPage1({Key? key}) : super(key: key);
//
//   @override
//   State<TodosOverviewPage1> createState() => _TodosOverviewPage1State();
// }
//
// class _TodosOverviewPage1State extends State<TodosOverviewPage1> {
// //   late List<Todo> listTodoMy;
// //   @override
// //   void initState(){
// //     listTodoMy = [
// //       Todo(title: 'Todo1', description: 'Description1'),
// //       Todo(title: 'Todo2', description: 'Description2'),
// //       Todo(title: 'Todo3', description: 'Description3'),
// //     ];
// //     super.initState();
// // }
//
//   @override
//   Widget build(BuildContext context) {
//     // return BlocProvider(
//     //   create: (context) => TodosOverviewBloc(
//     //     todosRepository: context.read<TodosRepository>(),
//     //   )..add(const TodosOverviewSubscriptionRequested()),
//     //   child: const TodosOverviewView(),
//     // );
//     return TodosOverviewView();
//   }
// }

