// import 'dart:convert';

// NoteSetting NotesResponseModelFromJson(String str) =>
//     NoteSetting.fromJson(json.decode(str));

// String NotesResponseModelToJson(NoteSetting data) => json.encode(data.toJson());

class NotesSetting {
  NotesSetting({
    required this.data,
  });

  List<Note> data;

  factory NotesSetting.fromJson(Map<String, dynamic> json) => NotesSetting(
        data: List<Note>.from(json["data"].map((item) => Note.fromJson(item))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((item) => item.toJson())),
      };
}

class NoteSetting {
  NoteSetting({
    required this.data,
  });

  Note data;

  factory NoteSetting.fromJson(Map<String, dynamic> json) => NoteSetting(
        data: Note.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Note {
  Note({
    required this.uuid,
    required this.category,
    required this.title,
    required this.reminder,
    required this.user_id,
    required this.createdAt,
    required this.updatedAt,
  });

  String uuid;
  int category;
  String title;
  DateTime reminder;
  String user_id;
  DateTime createdAt;
  DateTime updatedAt;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        uuid: json["uuid"],
        category: json["category"],
        title: json["title"],
        reminder: DateTime.parse(json["reminder"]),
        user_id: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        // token: json["token"],
        // tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "category": category,
        "title": title,
        "reminder": reminder,
        "user_id": user_id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        // "token": token,
        // "token_type": tokenType,
      };
}
