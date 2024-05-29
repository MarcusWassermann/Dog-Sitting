class UserText {
  final String id;
  final String text;
  final String? imagePath;

  UserText({required this.id, required this.text, this.imagePath});

  factory UserText.fromJson(Map<String, dynamic> json) {
    return UserText(
      id: json['id'],
      text: json['text'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'imagePath': imagePath,
    };
  }
}
