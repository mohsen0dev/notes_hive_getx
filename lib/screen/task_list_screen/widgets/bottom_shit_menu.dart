import 'package:flutter/material.dart';
import 'package:notes_hive_getx/controller/note_controller.dart';

class BottomShitMenu extends StatelessWidget {
  const BottomShitMenu({
    super.key,
    required this.noteControl,
    required this.hightButtomShit,
    required this.context,
  });

  final NotesController noteControl;
  final double hightButtomShit;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: noteControl.isLongTap.value,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 8,
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        height: hightButtomShit,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomShitItem(
                title: 'حذف',
                icon: Icons.delete_outline,
                onTap: () {
                  if (noteControl.notes.isNotEmpty) {
                    noteControl.deleteSelectedNotes();
                    noteControl.isLongTap.value = false;
                    noteControl.addFalseToList();
                    noteControl.update();
                    noteControl.isActive.value = false;
                    // noteControl.selectItems[index] = false;
                  }
                }),
            // BottomShitItem(
            //   title: 'انتقال',
            //   icon: Icons.drive_file_move_outlined,
            //   onTap: () {
            //     debugPrint('object');
            //     noteControl.isLongTap.value = false;
            //     noteControl.update();
            //   },
            // ),
            BottomShitItem(
              title: 'پین',
              icon: Icons.push_pin_outlined,
              onTap: () {
                if (noteControl.notes.isNotEmpty) {
                  noteControl.pinSelectedNotes();
                  noteControl.isLongTap.value = false;
                  noteControl.addFalseToList();
                  noteControl.update();
                  noteControl.isActive.value = false;
                  // noteControl.selectItems[index] = false;
                }
              },
            ),
            // BottomShitItem(
            //   title: 'مخفی',
            //   icon: Icons.lock_outline,
            //   onTap: () {
            //     if (noteControl.notes.isNotEmpty) {
            //       noteControl.hidenSelectedNotes();
            //       noteControl.isLongTap.value = false;
            //       noteControl.addFalseToList();
            //       noteControl.update();
            //       noteControl.isActive.value = false;
            //       // noteControl.selectItems[index] = false;
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
    // });
  }
}

class BottomShitItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTap;
  const BottomShitItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 36,
          ),
          Text(
            title,
            style: const TextStyle(),
          ),
        ],
      ),
    );
  }
}
