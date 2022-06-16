import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../logic/todos_api/models/todo.dart';
import '../todo_list/app.dart';

late Todo todo;

class EditTodo extends StatelessWidget {
  const EditTodo({Key? key}) : super(key: key);

  static Route<void> route({Todo? initialTodo, required bool isNewTodo1}) {
    if (isNewTodo1) {
      todo = Todo(
          id: const Uuid().v4(),
          title: '',
          description: '',
          isCompleted: false);
    } else {
      todo = Todo(
          id: initialTodo?.id,
          title: initialTodo!.title,
          description: initialTodo.description,
          isCompleted: initialTodo.isCompleted);
    }

    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const EditTodo(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const EditTodoView();
  }
}

class EditTodoView extends ConsumerWidget {
  const EditTodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(todo);
    final isNewTodo = ref.watch(appManagerProvider.select((p) => p.isNewTodo2));
    // if(isNewTodo){
    //   todo.title = '';
    //   todo.description = '';
    // }
    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;
    final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ??
        theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewTodo ? "NewTodo" : "Edit",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        backgroundColor: isNewTodo
            ? fabBackgroundColor.withOpacity(0.5)
            : fabBackgroundColor,
        onPressed: () {
          ref.watch(appManagerProvider.select((p) => p.saveTodo(todo)));
          // if (isNewTodo) {
          //   Todo todo1 = Todo(title: todo.title, description: todo.description);
          //   ref.watch(appManagerProvider.select((p) => p.saveTodo(todo1)));
          // } else {
          //   ref.watch(appManagerProvider.select((p) => p.saveTodo(todo)));
          // }
          // print(todo1);
          Navigator.of(context).pop();
        },
        child: false
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: const [_TitleField(), _DescriptionField()],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('editTodoView_title_textFormField'),
      initialValue: todo.title,
      decoration: InputDecoration(
        labelText: 'Title',
        hintText: 'Enter',
      ),
      maxLength: 100,
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
        // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) => todo.title = value,
    );
  }
}

class _DescriptionField extends ConsumerWidget {
  const _DescriptionField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      key: const Key('editTodoView_description_textFormField'),
      initialValue: todo.description,
      decoration: InputDecoration(
        labelText: 'Description',
        hintText: 'Enter',
      ),
      maxLength: 300,
      maxLines: 7,
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
      ],
      onChanged: (value) => todo.description = value,
    );
  }
}
