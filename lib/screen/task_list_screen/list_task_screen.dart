import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_hive_getx/controller/note_controller.dart';
import 'package:notes_hive_getx/screen/abute/abute.dart';
import 'package:notes_hive_getx/screen/settings_screen/settings_screen.dart';
import 'package:notes_hive_getx/screen/task_add_screen/add_task_screen.dart';
import 'package:notes_hive_getx/screen/task_list_screen/widgets/bottom_shit_menu.dart';
import 'package:notes_hive_getx/screen/task_list_screen/widgets/emty_widget.dart';
import 'package:notes_hive_getx/screen/task_list_screen/widgets/group_windget.dart';
import 'package:notes_hive_getx/screen/task_list_screen/widgets/items_task_widgets.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({super.key});

  final NotesController noteControl = Get.find<NotesController>();
  final double hightButtomShit = 70;
  final searchTxtController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    late bool back = false;
    late int backClick = 0;
    return GetBuilder<NotesController>(builder: (noteControll) {
      return PopScope(
          canPop: back,
          onPopInvokedWithResult: (didPop, result) =>
              handlePop(didPop, result, noteControll, back, backClick, context),
          child: Scaffold(
              // backgroundColor: const Color(0xFFF7F7F7),
              // appBar: appBarMetod(noteControll),
              floatingActionButton: fabAddNoteMetod(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              bottomSheet: BottomShitMenu(
                  noteControl: noteControl,
                  hightButtomShit: hightButtomShit,
                  context: context),
              body: NestedScrollView(
                  controller: scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        snap: false,
                        pinned: true,
                        floating: true,
                        flexibleSpace: const FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text("یادداشت ها",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ) //TextStyle
                              ), //Text
                        ), //FlexibleSpaceBar
                        expandedHeight: 150,

                        actions: <Widget>[
                          // IconButton(
                          //   icon: const Icon(Icons.create_new_folder_outlined),
                          //   tooltip: 'Comment Icon',
                          //   onPressed: () {},
                          // ), //IconButton
                          IconButton(
                            icon: const Icon(Icons.info_outline_rounded),
                            tooltip: 'Setting Icon',
                            onPressed: () {
                              Get.to(() => const AboutMeScreen());
                            },
                          ), //IconButton
                        ], //<Widget>[]
                      ), //SliverAppBar
                      SliverAppBar(
                        snap: false,
                        pinned: false,
                        floating: false,
                        // expandedHeight: 150,
                        flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            title:
                                searchMetod(noteControll)), //FlexibleSpaceBar
                      ), //SliverAppBar
                      // ),
                    ];
                  },
                  body: newMethod(noteControll))));
    });
    // });
  }

  Widget newMethod(NotesController noteControll) {
    return SizedBox(
      child: Column(
        children: [
          //! گروه بندی یادداشت ها
          // groupNoteMetod(context),
          //! لیست یادداشت ها
          Expanded(
              child: noteControll.notes.isEmpty
                  ? emptyView()
                  : ResultView(
                      contrroler: noteControll,
                      searchTxtController: searchTxtController,
                    )),
          SizedBox(
            height: noteControll.isLongTap.value
                ? hightButtomShit
                : hightButtomShit / 3,
          )
        ],
      ),
    );
  }

//! back botton metod
  void handlePop(
    bool didPop,
    Object? result,
    NotesController noteControll,
    bool back,
    int backClick,
    BuildContext context,
  ) {
    if (didPop) {
      return;
    }
    if (noteControll.isLongTap.isTrue) {
      noteControll.addFalseToList();
      noteControll.isLongTap.value = false;
      noteControll.isActive.value = false;
      noteControll.update();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Text('برای خروج دوباره دکمه بک را بزنید'),
              Spacer(),
              Icon(
                Icons.redo,
                color: Colors.white,
              ),
            ],
          ),
          duration: Duration(seconds: 1),
        ),
      );
      back = true;
      backClick = backClick + 1;
      if (backClick > 1) {
        exit(1);
      }
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          backClick = 0;
          back = false;
        },
      );
    }
  }

//! group widget
  Widget groupNoteMetod(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 8,
          itemBuilder: (context, index) {
            return Row(
              children: [
                index == 0
                    ? IconButton(onPressed: () {}, icon: const Icon(Icons.add))
                    : GroupWidgets(
                        name: index.toString(),
                      ),
              ],
            );
          }),
    );
  }

//! serch widget
  Widget searchMetod(NotesController control) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchTxtController,
                  onChanged: (value) {
                    control.searchNotesHiden(value);
                    control.update();
                  },
                  decoration: InputDecoration(
                    // fillColor: const Color(0xFFEDEDED),
                    filled: true,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: 'جستجوی یادداشت ها',
                    suffixIcon: IconButton(
                      onPressed: () {
                        control.searchNotesHiden(searchTxtController.text);
                        control.update();
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              if (control.isLongTap.value) const VerticalDivider(),
              if (control.isLongTap.value)
                Text(
                  noteControl.selectItems
                      .where((element) => element)
                      .length
                      .toString(),
                ),
            ],
          ),
        ));
  }

//! appbar
  AppBar appBarMetod(NotesController noteControll) {
    return AppBar(
      title: const Text('یادداشت ها'),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Get.to(const SettingsScreen());
            },
            icon: const Icon(Icons.settings_outlined)),
      ],
      leading: Visibility(
        visible: noteControll.isLongTap.isTrue,
        child: IconButton(
            onPressed: () {
              noteControll.isActive.value = false;
              noteControll.isLongTap.value = false;
              noteControll.addFalseToList();
              noteControll.update();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
    );
  }

//! fab add note
  Widget fabAddNoteMetod() {
    return Visibility(
      visible: !noteControl.isLongTap.value,
      child: FloatingActionButton(
        heroTag: 'addTask',
        onPressed: () async {
          await Get.to(() => const TaskAddScreen());
          // noteControl.addFalseToList();
          // noteControl.addBoxToList();
          // noteControl.update();
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }

//! buttomsheet
}

//! result view
class ResultView extends StatelessWidget {
  final NotesController contrroler;
  final TextEditingController searchTxtController;
  const ResultView({
    super.key,
    required this.contrroler,
    required this.searchTxtController,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: contrroler.searchNotesHiden(searchTxtController.text).length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
            // height: 1,
            );
      },
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        final note =
            contrroler.searchNotesHiden(searchTxtController.text)[index];
        // contrroler.selectItemsUpdate();
        // contrroler.addFalseToList();
        return TaskItemsWidgets(
            index: index, note: note, select: contrroler.selectItems[index]);
      },
    );
  }
}
