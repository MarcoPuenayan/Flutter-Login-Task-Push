import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/ui/screens/task_list_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor de Tareas',
      theme: ThemeData(
        primaryColor: const Color(0xFF755DC1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF755DC1),
          error: Colors.redAccent,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Color(0xFF393939),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const TaskListScreen(),
    );
  }
}