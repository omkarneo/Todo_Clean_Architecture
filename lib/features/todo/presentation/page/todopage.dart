import 'package:flutter/material.dart';

import '../widget/dialog.dart';
import '../widget/updateDialog.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Map> data = [
    {
      "Task": "BreakFast",
      "Time":
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
      "Dropdown": "AT HOME"
    },
    {
      "Task": "Jog",
      "Time":
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
      "Dropdown": "AWAY"
    },
    {
      "Task": "Preparing Task",
      "Time":
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
      "Dropdown": "AT OFFICE"
    },
    {
      "Task": "Meeting at 10",
      "Time":
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
      "Dropdown": "AT OFFICE"
    },
    {
      "Task": "Programming",
      "Time":
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
      "Dropdown": "AT OFFICE"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TODO",
          style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        leading: const Icon(
          Icons.flutter_dash,
          color: Colors.black,
        ),
        backgroundColor: Color(0xFFC9F6FF),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) {
            // var data = snapshot.data![index];
            return ListTile(
              // tileColor: customColor,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: Text("data.task"),
              subtitle: Text("${"data.location"} ${"data.time"} "),
              leading: const Icon(Icons.add_task_rounded),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => {},
              ),
              onLongPress: () async {
                try {} catch (err) {
                  print(err);
                }
              },
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
              // child: Text("----------"),
            );
          },
          itemCount: 10),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFC9F6FF),
        onPressed: () async {
          try {
            Map todotask = await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const DialogTodo());
            print(todotask);
            if (todotask['Changed'] == true) {
              // await db.insertData(Task(
              //     task: todotask['Task'],
              //     time: todotask['Time'],
              //     location: todotask['location']));
              // setState(() {
              //   data.add(todotask);
              // });
            }
          } catch (err) {
            print(err);
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
