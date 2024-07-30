import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:notes_hive_getx/models/note_model.dart';

class NotesController extends GetxController {
  @override
  void onInit() {
    // loadboxtolist();
    // searchNotes();
    super.onInit();
  }

  /// فعال بودن تاچ طولانی
  late RxBool isLongTap = false.obs;

  /// هایو باکس یادداشتها
  var noteBox = Hive.box<NoteModels>('note').obs;

  /// لیست یادداشت ها
  RxList<NoteModels> notes = RxList.empty();

  // var isLongTap = false.obs;
  var isSearch = false.obs;

  /// فعال کردن ایتم انتخاب شده
  RxBool isActive = false.obs;
  // RxList selectItemCount = [].obs;

  late RxList<bool> selectItems = List.generate(notes.length, (index) {
    return false;
  }).obs;

  selectItemsUpdate() {
    selectItems = List.generate(notes.length, (index) {
      return false;
    }).obs;
  }

  RxList<NoteModels> addBoxToList() {
    var note = (noteBox.value)
        .values
        .where((element) {
          return true; // برگرداندن همه موارد در صورتی که searchText خالی باشد
        })
        .toList()
        .obs;
    // update();
    return notes = note;
  }

  RxList<NoteModels> searchNotesHiden([String? searchText]) {
    var note = (noteBox.value)
        .values
        .where((element) {
          String title = element.title;
          String description = element.note;
          if (searchText == null || searchText.isEmpty) {
            return element.isHiden == false
                ? true
                : false; // برگرداندن همه موارد در صورتی که searchText خالی باشد
          } else {
            return title.contains(searchText) && element.isHiden == false ||
                description.contains(searchText) && element.isHiden == false;
          }
        })
        .toList()
        .obs;
    // update();
    note.sort((a, b) {
      if (a.isPin && !b.isPin) {
        return -1;
      } else if (!a.isPin && b.isPin) {
        return 1;
      } else {
        return b.key!.compareTo(a.key!);
      }
    });

    return notes = note;
  }

  RxList<NoteModels> searchNotesAll([String? searchText]) {
    var note = (noteBox.value)
        .values
        .where((element) {
          String title = element.title;
          String description = element.note;
          if (searchText == null || searchText.isEmpty) {
            return true; // برگرداندن همه موارد در صورتی که searchText خالی باشد
          } else {
            return title.contains(searchText) && element.isHiden == false ||
                description.contains(searchText) && element.isHiden == false;
          }
        })
        .toList()
        .obs;
    // update();
    note.sort((a, b) {
      if (a.isPin && !b.isPin) {
        return -1;
      } else if (!a.isPin && b.isPin) {
        return 1;
      } else {
        return a.key!.compareTo(b.key!);
      }
    });

    return notes = note;
  }

  /// غییر فعال کردن همه چک باکس ها یا ایتم های انتخاب شده
  addFalseToList() {
    selectItems.assignAll(List.generate(notes.length, (index) {
      return false;
    }));
  }

  void deleteSelectedNotes() {
    List<NoteModels> selectedNotes = [];

    // یافتن ایتم‌های انتخاب شده
    for (int i = 0; i < notes.length; i++) {
      if (selectItems[i]) {
        selectedNotes.add(notes[i]);
      }
    }

    // حذف ایتم‌های انتخاب شده از باکس و لیست
    for (var note in selectedNotes) {
      noteBox.value.delete(note.key);
      notes.remove(note);
    }
  }

  void pinSelectedNotes() {
    searchNotesHiden();
    List<NoteModels> selectedNotes = [];

    // یافتن ایتم‌های انتخاب شده
    for (int i = 0; i < notes.length; i++) {
      if (selectItems[i]) {
        selectedNotes.add(notes[i]);
      }
    }

    // حذف ایتم‌های انتخاب شده از باکس و لیست
    for (var note in selectedNotes) {
      noteBox.value.put(note.key, note.copyWith(isPin: !note.isPin));
      notes[notes.indexOf(note)] = note.copyWith(isPin: !note.isPin);
    }
  }

  void hidenSelectedNotes() {
    searchNotesAll();
    List<NoteModels> selectedNotes = [];

    // یافتن ایتم‌های انتخاب شده
    for (int i = 0; i < notes.length; i++) {
      if (selectItems[i]) {
        selectedNotes.add(notes[i]);
      }
    }

    // حذف ایتم‌های انتخاب شده از باکس و لیست
    for (var note in selectedNotes) {
      noteBox.value.put(note.key, note.copyWith(isHiden: !note.isHiden));
      notes[note.key] = note.copyWith(isHiden: !note.isHiden);
    }
  }
}
