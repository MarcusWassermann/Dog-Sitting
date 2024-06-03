class UserProfile {
  final String id; // Eindeutige ID hinzugefügt
  final String? imagePath;
  final String? username;
  final String? zipCode;
  final String? additionalInfo; // Text

  UserProfile({
    required this.id, // ID im Konstruktor erforderlich
    this.imagePath,
    this.username,
    this.zipCode,
    this.additionalInfo,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String? ?? '', // ID aus JSON lesen
      imagePath: json['imagePath'] as String?,
      username: json['username'] as String?,
      zipCode: json['zipCode'] as String?,
      additionalInfo: json['additionalInfo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // ID zu JSON hinzufügen
      'imagePath': imagePath,
      'username': username,
      'zipCode': zipCode,
      'additionalInfo': additionalInfo,
    };
  }
}
