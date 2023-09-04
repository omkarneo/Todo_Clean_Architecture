import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_cleanarch/features/todo/presentation/bloc/todo_bloc.dart';
// import 'package:todo_with_localstorage/Pages/todopage.dart';
import 'dart:async';

import 'di_container.dart';
import 'features/todo/presentation/page/todopage.dart';
// import 'package:todo_with_localstorage/staticdata.dart';

void main() async {
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<TodoBloc>(),
      child: MaterialApp(
        title: "Todo With Local Storage",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFFC9F6FF),
        ),
        routes: {
          "/": (context) => const FirstPage(),
          "/todo": (context) => const TodoList(),
        },
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    var duration = const Duration(milliseconds: 1000);
    Timer(
      duration,
      () => Navigator.pushReplacementNamed(context, '/todo'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.flutter_dash, size: 150),
              Text(
                "Todo App with Clean Architecture",
                style: TextStyle(fontSize: 25, fontFamily: "Montserrat"),
              ),
            ]),
      ),
    );
  }
}
