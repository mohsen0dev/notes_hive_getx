import 'package:get/get.dart';
import 'package:notes_hive_getx/constans/list_color.dart';

class ThemeController extends GetxController {
  late RxBool visTheme = false.obs;

  Rx<SelectColor> selectColor = listColor[0].obs;
  RxInt indexColorTheme = 0.obs;
}
