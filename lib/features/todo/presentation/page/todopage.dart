// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../widget/dialog.dart';
import '../widget/updateDialog.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    BlocProvider.of<TodoBloc>(context).add(TodoLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
        actions: [
          IconButton(
              onPressed: () async {
                // Navigator.pushNamed(context, '/emp');
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Are you Sure to Delete All Todos"),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel")),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  BlocProvider.of<TodoBloc>(context)
                                      .add(ClearAllTodoEvent());
                                  Navigator.pop(context);
                                },
                                child: const Text("Confirm"))
                          ],
                        )
                      ],
                    );
                  },
                );
                BlocProvider.of<TodoBloc>(context).add(TodoLoadEvent());
              },
              icon: const Icon(Icons.remove_circle))
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoadedState) {
            return FutureBuilder(
                future: state.alltodo,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length != 0) {
                      return ListView.separated(
                          itemCount: snapshot.data.length,
                          padding: const EdgeInsets.all(20),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemBuilder: (context, index) {
                            var data = snapshot.data![index];
                            print(data.runtimeType);
                            return ListTile(
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              title: Text("${data.task}"),
                              subtitle: Text("${data.location} ${data.time} "),
                              leading: const Icon(Icons.add_task_rounded),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                        "Confirmation to Delete Todo",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      actions: [
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Want to Delete todo ?",
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel')),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  BlocProvider.of<TodoBloc>(
                                                          context)
                                                      .add(DeleteTodo(data));
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Confirm')),
                                          ],
                                        )
                                      ],
                                    ),
                                  ).then((value) => {
                                        BlocProvider.of<TodoBloc>(context)
                                            .add(TodoLoadEvent())
                                      })
                                },
                              ),
                              onLongPress: () async {
                                Map todotask = await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => UpdateDialogTodo(
                                          task: data,
                                        ));
                                print(todotask);
                                if (todotask['Changed'] == true) {
                                  BlocProvider.of<TodoBloc>(context)
                                      .add(UpdateTodo(todotask));
                                  BlocProvider.of<TodoBloc>(context)
                                      .add(TodoLoadEvent());
                                }
                              },
                            );
                          });
                    } else {
                      return const Center(child: Text("No Todo Found"));
                    }
                  } else {
                    return const Text("Loadins");
                  }
                });
          } else {
            return const Text("Loading");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map todotask = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const DialogTodo());
          print(todotask);
          if (todotask['Changed'] == true) {
            print(todotask);
          }
          BlocProvider.of<TodoBloc>(context).add(CreateTodo(todotask));
          BlocProvider.of<TodoBloc>(context).add(TodoLoadEvent());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
