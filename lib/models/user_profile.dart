class UserProfile {
  final String? imagePath;
  final String? text;
  final String? username;
  final String? zipCode; // Änderung von "postcode" zu "zipCode"
  final String? additionalInfo;

  UserProfile({
    this.imagePath,
    this.text,
    this.username,
    this.zipCode, // Aktualisiertes Feld "zipCode"
    this.additionalInfo,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      imagePath: json['imagePath'] as String?,
      text: json['text'] as String?,
      username: json['username'] as String?,
      zipCode: json['zipCode'] as String?, // Aktualisiertes Feld "zipCode"
      additionalInfo: json['additionalInfo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'text': text,
      'username': username,
      'zipCode': zipCode, // Aktualisiertes Feld "zipCode"
      'additionalInfo': additionalInfo,
    };
  }
}
