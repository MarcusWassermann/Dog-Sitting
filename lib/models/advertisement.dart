class Advertisement {
  final int id;
  final String text;
  final String postcode;
  final String? imagePath;

  Advertisement({
    required this.id,
    required this.text,
    required this.postcode,
    this.imagePath,
  });

  factory Advertisement.fromMap(Map<String, dynamic> map) {
    return Advertisement(
      id: map['id'],
      text: map['text'],
      postcode: map['postcode'],
      imagePath: map['imagePath'],
    );
  }
}
