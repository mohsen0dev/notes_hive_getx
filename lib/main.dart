import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_hive_getx/controller/note_controller.dart';
import 'package:notes_hive_getx/models/note_model.dart';
import 'package:notes_hive_getx/screen/task_list_screen/list_task_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelsAdapter());
  await Hive.openBox<NoteModels>('note');
  final NotesController noteControl = Get.put(NotesController());
  noteControl.addBoxToList();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      textDirection: TextDirection.rtl,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      themeMode: ThemeMode.light,
      home: TaskListScreen(),
    );
  }
}
