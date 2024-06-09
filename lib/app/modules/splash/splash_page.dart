import 'package:flutter/material.dart';
import 'package:todo_list/app/core/widgets/todo_list_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: const Center(
        child: TodoListLogo(),
      ),
    );
  }
}
