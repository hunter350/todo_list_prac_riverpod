import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../logic/app_managment/app_manager.dart';
import '../../logic/todos_repository/todos_repository.dart';
import '../theme/theme.dart';
import 'home_page.dart';

 late final appManagerProvider;

class App extends StatelessWidget {
  const App({Key? key, required this.todosRepository}) : super(key: key);

  final TodosRepository todosRepository;

  @override
  Widget build(BuildContext context) {
    return   AppView(todosRepository: todosRepository);
  }
}

class AppView extends StatelessWidget {
 AppView({Key? key, required this.todosRepository}){
   appManagerProvider = ChangeNotifierProvider((ref) {

     return AppManager(todosRepository: todosRepository);
   });
 }
     //: super(key: key) ;

  final TodosRepository todosRepository;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: FlutterTodosTheme.light,
        darkTheme: FlutterTodosTheme.dark,
        home: const HomePage(),
      ),
    );
  }
}
