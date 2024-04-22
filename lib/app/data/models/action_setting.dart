class ActionSetting {
  ActionSetting({
    required this.message,
  });

  String message;

  factory ActionSetting.fromJson(Map<String, dynamic> json) => ActionSetting(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
