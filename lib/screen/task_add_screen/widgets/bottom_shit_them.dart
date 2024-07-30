import 'package:flutter/material.dart';
import 'package:notes_hive_getx/constans/list_color.dart';
import 'package:notes_hive_getx/controller/theme_controller.dart';

class BottomShitThem extends StatelessWidget {
  final Color backColor;
  final Color textColor;
  final int index;
  final ThemeController themeController;
  const BottomShitThem(
      {super.key,
      required this.backColor,
      required this.textColor,
      required this.themeController,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        themeController.selectColor.value = SelectColor(backColor, textColor);
        themeController.indexColorTheme.value = index;
        themeController.update();
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: 80,
        // height: 80,
        child: Text(
          'متن نمایشی',
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
