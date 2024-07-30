import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart' as intl;
import 'package:notes_hive_getx/constans/list_color.dart';
import 'package:notes_hive_getx/controller/theme_controller.dart';
import 'package:notes_hive_getx/screen/task_add_screen/widgets/bottom_shit_them.dart';
import 'package:notes_hive_getx/screen/task_list_screen/widgets/permission.dart';
import 'package:scroll_screenshot/scroll_screenshot.dart';

class ShareScreen extends StatelessWidget {
  final String title;
  final String note;
  ShareScreen({super.key, required this.title, required this.note});

  final ThemeController themeController = Get.find<ThemeController>();

  final GlobalKey globalKey = GlobalKey();
  final RxBool change = false.obs;

  Future<void> _captureAndSaveScreenshot() async {
    final per = await permission();
    if (per == false) {
      return;
    }
    print('object');
    String? base64String =
        await ScrollScreenshot.captureAndSaveScreenshot(globalKey);

    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      Uint8List bytes = base64Decode(base64String!);
      final result = await ImageGallerySaver.saveImage(bytes);
      debugPrint('byte= $result');
    } else {
      throw Exception('Failed to capture widget as image');
    }
  }

  @override
  Widget build(BuildContext context) {
    late bool back = false;
    // RxInt connter = noteCtrl.text.length.obs;

    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    themeController.visTheme.value =
                        !themeController.visTheme.value;
                  },
                  icon: const Icon(Icons.palette_outlined)),
              const Text('اشتراک یادداشت'),
              const SizedBox(
                width: 80,
              )
            ],
          ),
        ),
        bottomSheet: bottomShThemeMetod(context),
        floatingActionButton: fabAddNoteMetod(),
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
                                // saveNote();
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
          child: SingleChildScrollView(
            child: RepaintBoundary(
              key: globalKey,
              child: GetBuilder<ThemeController>(builder: (themeController) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeController.selectColor.value.backColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: themeController.selectColor.value.backColor,
                          border: Border.all(
                              color:
                                  themeController.selectColor.value.textColor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (title.isNotEmpty)
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  title,
                                  textAlign: intl.Bidi.hasAnyRtl(title)
                                      ? TextAlign.right
                                      : TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: themeController
                                        .selectColor.value.textColor,
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                note,
                                textAlign: intl.Bidi.hasAnyRtl(note)
                                    ? TextAlign.right
                                    : TextAlign.left,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: themeController
                                      .selectColor.value.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Center(child: Text('ساخته شده توسط نت محسن')),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ));
  }

  fabAddNoteMetod() {
    return FloatingActionButton(
      onPressed: _captureAndSaveScreenshot,
      child: const Icon(
        Icons.save_alt_rounded,
        size: 30,
      ),
    );
  }

  Obx bottomShThemeMetod(BuildContext context) {
    return Obx(() {
      return Visibility(
          visible: themeController.visTheme.value,
          child: SizedBox(
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
                      index: index,
                      backColor: listColor[index].backColor,
                      textColor: listColor[index].textColor,
                    );
                  }),
            ),
          ));
    });
  }
}
