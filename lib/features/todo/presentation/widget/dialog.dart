import 'package:flutter/material.dart';
// import 'package:todo_with_localstorage/staticdata.dart';

class DialogTodo extends StatefulWidget {
  const DialogTodo({super.key});

  @override
  State<DialogTodo> createState() => _DialogTodoState();
}

class _DialogTodoState extends State<DialogTodo> {
  Map data = {"Task": "", "Time": "", "location": "AT HOME", "Changed": false};
  TextEditingController task = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List option = ["AT OFFICE", "AT HOME", "AWAY"];
    return Form(
      key: formKey,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        // contentPadding: EdgeInsets.all(20),
        title: const Text("Add Task"),
        content: const Text("Add the Task for the List"),
        buttonPadding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
        actions: [
          TextFormField(
            controller: task,
            decoration: const InputDecoration(hintText: "Task"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ("It Should be Empty");
              } else {
                return (null);
              }
            },
          ),
          Row(
            children: [
              const Text("Location :- "),
              DropdownButton(
                value: data['location'],
                // value: Text(data['Dropdown']),
                items: option
                    .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => {
                  setState(() {
                    data["location"] = value;
                  })
                },
              ),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // backgroundColor: customColor,
                  ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  data["Task"] = task.text;
                  data['Time'] =
                      "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
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
