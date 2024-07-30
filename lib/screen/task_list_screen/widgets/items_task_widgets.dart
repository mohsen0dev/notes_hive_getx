import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_hive_getx/controller/note_controller.dart';
import 'package:notes_hive_getx/models/note_model.dart';
import 'package:notes_hive_getx/screen/task_add_screen/add_task_screen.dart';

class TaskItemsWidgets extends StatelessWidget {
  final int index;
  final NoteModels note;
  final bool? select;

  const TaskItemsWidgets({
    super.key,
    required this.index,
    required this.note,
    this.select,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(builder: (ctrl) {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: select! ? Colors.indigo[100] : Colors.white,
            ),
            margin: const EdgeInsets.fromLTRB(8, 0, 8, 18),
            padding: const EdgeInsets.all(16),
            height: 115,
            child: InkWell(
              onLongPress: () {
                //! اگر لانگ تاچ نبود
                if (ctrl.isLongTap.isFalse) {
                  //! اگر ایتم انتخاب نشده بود
                  if (ctrl.isActive.isFalse) {
                    ctrl.isActive.value = true;
                    ctrl.isLongTap.value = !ctrl.isLongTap.value;
                    ctrl.selectItems[index] = true;
                    ctrl.update();
                  }
                  //! اگر ایتم انتخاب شده بود
                  else {
                    ctrl.isActive.value = false;
                    ctrl.isLongTap.value = !ctrl.isLongTap.value;
                    ctrl.selectItems[index] = false;
                    ctrl.addFalseToList();
                    ctrl.update();
                  }
                }
                //! اگر لانگ تاچ بود
                else {
                  ctrl.isActive.value = false;
                  ctrl.isLongTap.value = !ctrl.isLongTap.value;
                  ctrl.addFalseToList();
                  ctrl.update();
                }
              },
              onTap: () {
                //! اگر لانگ تاچ بود
                if (ctrl.isLongTap.isTrue) {
                  ctrl.isActive.value = !ctrl.isActive.value;
                  ctrl.selectItems[index] = !ctrl.selectItems[index];
                  ctrl.update();
                }
                //! اگر لانگ تاچ نبود
                else {
                  Get.to(TaskAddScreen(
                    box: ctrl.notes[index],
                    index: index,
                  ));
                }
              },
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! عنوان
                  Text(
                    note.title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  //! متن یادداشت
                  Text(
                    note.note,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  const Spacer(),
                  //! تاریخ
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Spacer(),
                      // Text(' pin=${ctrl.notes[index].isPin} '),
                      // Text(' hiden=${ctrl.notes[index].isHiden} '),
                      Text(
                        '${ctrl.notes[index].date}',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //! چک باکس
          Positioned(
            bottom: 18,
            right: 16,
            child: Visibility(
              visible: ctrl.isLongTap.value,
              child: CustomChekBox(
                  noteController: ctrl, index: index, isActive: ctrl.isActive),
            ),
          ),
          //! pin icon
          Visibility(
            visible: ctrl.notes[index].isPin,
            child: Positioned(
              top: 8,
              left: 16,
              child: Transform.rotate(
                angle: 5.70,
                child: const Icon(
                  Icons.push_pin_outlined,
                  // color: Colors.red,
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}

class CustomChekBox extends StatefulWidget {
  const CustomChekBox({
    super.key,
    required this.noteController,
    required this.index,
    required this.isActive,
  });

  final NotesController noteController;
  final int index;
  final RxBool isActive;

  @override
  State<CustomChekBox> createState() => _CustomChekBoxState();
}

class _CustomChekBoxState extends State<CustomChekBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        splashRadius: 15,
        value: widget.noteController.selectItems[widget.index],
        onChanged: (v) {
          setState(() {
            widget.noteController.selectItems[widget.index] =
                !widget.noteController.selectItems[widget.index];
          });
          // if (widget.isActive.isTrue) {
          // widget.noteController.selectItemCount.add(widget.index);
          // } else {
          // widget.noteController.selectItemCount.remove(widget.index);
          // }
        });
  }
}
