import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/models/tasks_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {
  final TasksModel model;
  final dateFormat = DateFormat('dd/MM/y');
  Task({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.grey),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: Dismissible(
          key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
          onDismissed: (d) {
            context.read<HomeController>().deleteTask(model.id);
          },
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: Checkbox(
              value: model.finished,
              onChanged: (v) =>
                  context.read<HomeController>().checkOrUncheckTask(model),
            ),
            title: Text(
              model.description,
              style: TextStyle(
                  decoration:
                      model.finished ? TextDecoration.lineThrough : null),
            ),
            subtitle: Text(
              dateFormat.format(model.dateTime),
              style: TextStyle(
                  decoration:
                      model.finished ? TextDecoration.lineThrough : null),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(width: 1)),
          ),
        ),
      ),
    );
  }
}
