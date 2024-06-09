class UserProfile {
  final String id;
  final String? imagePath;
  final String? username;
  final String? zipCode;
  final String? additionalInfo;
  bool isFilled; // Neues Feld für den Füllungszustand des Herzens

  UserProfile({
    required this.id,
    this.imagePath,
    this.username,
    this.zipCode,
    this.additionalInfo,
    this.isFilled = false, // Standardmäßig auf false gesetzt
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String? ?? '',
      imagePath: json['imagePath'] as String?,
      username: json['username'] as String?,
      zipCode: json['zipCode'] as String?,
      additionalInfo: json['additionalInfo'] as String?,
      isFilled:
          json['isFilled'] as bool? ?? false, // Füllungszustand aus JSON lesen
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'username': username,
      'zipCode': zipCode,
      'additionalInfo': additionalInfo,
      'isFilled': isFilled, // Füllungszustand zu JSON hinzufügen
    };
  }
}
