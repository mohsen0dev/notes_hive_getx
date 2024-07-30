import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModels extends HiveObject {
  @HiveField(0)
  String? id = '';
  @HiveField(1)
  String title = '';
  @HiveField(2)
  String note = '';
  @HiveField(3)
  String theme = '';
  @HiveField(4)
  String? date = '';
  @HiveField(5)
  bool isPin = false;
  @HiveField(6)
  bool isHiden = false;

  NoteModels({
    this.id,
    required this.title,
    required this.note,
    required this.theme,
    required this.date,
    required this.isPin,
    required this.isHiden,
  });

  NoteModels copyWith({
    String? title,
    String? note,
    String? theme,
    String? date,
    bool? isPin,
    bool? isHiden,
  }) {
    return NoteModels(
      title: title ?? this.title,
      note: note ?? this.note,
      theme: theme ?? this.theme,
      date: date ?? this.date,
      isPin: isPin ?? this.isPin,
      isHiden: isHiden ?? this.isHiden,
    );
  }
}
