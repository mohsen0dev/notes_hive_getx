import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_hive_getx/constans/list_color.dart';
import 'package:notes_hive_getx/controller/note_controller.dart';
import 'package:notes_hive_getx/controller/theme_controller.dart';
import 'package:notes_hive_getx/models/note_model.dart';
import 'package:notes_hive_getx/screen/share/share_screen.dart';
import 'package:notes_hive_getx/screen/task_add_screen/widgets/bottom_shit_them.dart';
import 'package:notes_hive_getx/tools/shamsi_convert.dart';

class TaskAddScreen extends StatefulWidget {
  final NoteModels? box;
  final NotesController? selectItems;
  final int? index;
  const TaskAddScreen({super.key, this.box, this.selectItems, this.index});

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final GlobalKey globalKey = GlobalKey();
  // ScreenshotController screenshotController = ScreenshotController();
  GlobalKey<FormFieldState> singleLineTextFieldKey =
      GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> multiLineTextFieldKey = GlobalKey<FormFieldState>();
  final titleCtrl = TextEditingController();
  final noteCtrl = TextEditingController();

  final ThemeController themeController = Get.put(ThemeController());
  final NotesController selectItems = Get.put(NotesController());
  RxBool change = false.obs;
  @override
  void initState() {
    if (widget.box != null) {
      titleCtrl.text = widget.box!.title;
      noteCtrl.text = widget.box!.note;
      themeController.selectColor.value = SelectColor(
          listColor[int.parse(widget.box!.theme)].backColor,
          listColor[int.parse(widget.box!.theme)].textColor);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late bool back = false;
    RxInt connter = noteCtrl.text.length.obs;

    return Obx(() {
      return Scaffold(
          backgroundColor: themeController.selectColor.value.backColor,
          appBar: AppBar(
            backgroundColor: themeController.selectColor.value.backColor,
            centerTitle: true,
            title: Row(
              children: [
                IconButton(
                    onPressed: () {
                      themeController.visTheme.value =
                          !themeController.visTheme.value;
                    },
                    icon: const Icon(Icons.palette_outlined)),
                IconButton(
                    onPressed: () async {
                      themeController.visTheme.value = false;
                      Get.to(ShareScreen(
                        title: titleCtrl.text,
                        note: noteCtrl.text,
                      ))!
                          .then((_) {
                        themeController.visTheme.value = false;
                      });
                      // shareMetod(globalKey, multiLineTextFieldKey,
                      //     singleLineTextFieldKey);
                    },
                    icon: const Icon(Icons.share_outlined)),
              ],
            ),
            actions: [
              Hero(
                tag: 'addTask',
                child: IconButton(
                    onPressed: () {
                      saveNote();
                    },
                    icon: const Icon(Icons.task_alt_outlined)),
              )
            ],
          ),
          bottomSheet: bottomShThemeMetod(context),
          body: PopScope(
            canPop: back,
            onPopInvokedWithResult: (bool didPop, Object? result) {
              if (didPop) {
                return;
              }
              themeController.visTheme.value
                  ? themeController.visTheme.value = false
                  : change.value == true
                      ? showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('هشدار'),
                            content:
                                const Text('آیا میخواهید اطلاعات ذخیره شود؟'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('ذخیره'),
                                onPressed: () {
                                  back = true;
                                  saveNote();
                                  Get.back();
                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: const Text('خیر'),
                                onPressed: () {
                                  back = true;
                                  Get.back();
                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: const Text('انصراف از خروج'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        )
                      : Get.back();
            },
            child: Container(
              color: themeController.selectColor.value.backColor,
              child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Column(
                    children: [
                      TextField(
                        key: singleLineTextFieldKey,
                        controller: titleCtrl,
                        style: TextStyle(
                            color: themeController.selectColor.value.textColor),
                        decoration: InputDecoration(
                          // fillColor:
                          //     themeController.selectColor.value.backColor,
                          // filled: true,
                          border: InputBorder.none,
                          hintText: 'عنوان',
                          hintStyle: TextStyle(
                              color: themeController.selectColor.value.textColor
                                  .withOpacity(0.5)),
                        ),
                        onChanged: (value) {
                          change.value = true;
                        },
                      ),
                      Row(
                        children: [
                          Text(
                            convertGregorianToJalali(DateTime.now()),
                            style: TextStyle(
                                fontSize: 12,
                                color: themeController
                                            .selectColor.value.backColor ==
                                        Colors.black26
                                    ? Colors.grey
                                    : Colors.black87),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              color:
                                  themeController.selectColor.value.backColor ==
                                          Colors.black26
                                      ? Colors.grey
                                      : Colors.black87,
                              width: 8,
                              height: 1),
                          Obx(() {
                            return Text(
                              'تعداد ${connter.value} حرف',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: themeController
                                              .selectColor.value.backColor ==
                                          Colors.black26
                                      ? Colors.grey
                                      : Colors.black87),
                            );
                          }),
                        ],
                      ),
                      Expanded(
                          child: TextField(
                        key: multiLineTextFieldKey,
                        style: TextStyle(
                            color: themeController.selectColor.value.textColor),
                        autofocus: true,
                        controller: noteCtrl,
                        maxLines: null,
                        minLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'متن',
                          hintStyle: TextStyle(
                              color: themeController.selectColor.value.textColor
                                  .withOpacity(0.5)),
                        ),
                        onChanged: (value) {
                          change.value = true;
                        },
                      )),
                    ],
                  )),
            ),
          ));
    });
  }

  Obx bottomShThemeMetod(BuildContext context) {
    return Obx(() {
      return Visibility(
          visible: themeController.visTheme.value,
          child: SizedBox(
            // color: Colors.amberAccent,
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(4),
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return BottomShitThem(
                      themeController: themeController,
                      backColor: listColor[index].backColor,
                      textColor: listColor[index].textColor,
                      index: index,
                    );
                  }),
            ),
          ));
    });
  }

  void saveNote() async {
    if (widget.box != null) {
      //! edit note
      widget.box!.title = titleCtrl.text;
      widget.box!.note = noteCtrl.text;
      widget.box!.date = convertGregorianToJalali(DateTime.now());
      widget.box!.theme = themeController.indexColorTheme.value.toString();
      selectItems.noteBox.value.put(widget.box!.key, widget.box!);
      // selectItems.noteBox.value.put(key, value)
      // selectItems.noteBox.value. [widget.box!.key] = widget.box!;

      // selectItems.notes[widget.index!] = widget.box!;
      // selectItems.notes[widget.box!.key] = widget.box!;
    } else {
      //! add note
      // selectItems.notes.add(
      //   NoteModels(
      //     title: titleCtrl.text,
      //     note: noteCtrl.text,
      //     date: convertGregorianToJalali(DateTime.now()),
      //     theme: '1',
      //   ),
      // );
      await selectItems.noteBox.value.add(
        NoteModels(
          id: UniqueKey().toString(),
          title: titleCtrl.text,
          note: noteCtrl.text,
          date: convertGregorianToJalali(DateTime.now()),
          theme: themeController.indexColorTheme.value.toString(),
          isPin: false,
          isHiden: false,
        ),
      );
      selectItems.selectItems.add(false);

      // selectItems.addBoxToList();
      // selectItems.searchNotes();
      // selectItems.update();
    }
    selectItems.addBoxToList();
    //
    // selectItems.searchNotes();
    selectItems.update();
    Get.back();
  }
}
