import 'package:flutter/material.dart';
// import 'package:todo_with_localstorage/Model/Task.dart';
// import 'package:todo_with_localstorage/staticdata.dart';

class UpdateDialogTodo extends StatefulWidget {
  // final Task? task;
  const UpdateDialogTodo({super.key});

  @override
  State<UpdateDialogTodo> createState() => _UpdateDialogTodoState();
}

class _UpdateDialogTodoState extends State<UpdateDialogTodo> {
  late Map data;

  @override
  void initState() {
    super.initState();
    // task.text = widget.task!.task.toString();
    // data = {
    //   "id": widget.task!.id,
    //   "Task": "",
    //   "Time": widget.task!.time.toString(),
    //   "Location": widget.task!.location.toString(),
    //   "Changed": false
    // };
  }

  final formKey = GlobalKey<FormState>();
  late TextEditingController task = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List option = ["AT OFFICE", "AT HOME", "AWAY"];
    return Form(
      key: formKey,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: const Text("Add Task"),
        content: const Text("Add the Task for the List"),
        buttonPadding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        actions: [
          TextFormField(
            controller: task,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ("Please Enter Task");
              }
              return (null);
            },
          ),
          Row(
            children: [
              const Text("Location :- "),
              DropdownButton(
                value: data['Location'],
                // value: Text(data['Dropdown']),
                items: option
                    .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => {
                  setState(() {
                    data["Location"] = value;
                    data['Time'] =
                        "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
                    data["Changed"] = true;
                  })
                },
              ),
            ],
          ),
          ElevatedButton(
              // style: ElevatedButton.styleFrom(backgroundColor: customColor),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  data['Task'] = task.text;
                  data['Changed'] = true;
                  Navigator.pop(context, data);
                }
              },
              child: const Text(
                "Add Task",
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }
}
