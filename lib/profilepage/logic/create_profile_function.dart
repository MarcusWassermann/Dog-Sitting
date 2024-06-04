// ignore_for_file: use_build_context_synchronously

import 'package:dogs_sitting/profilepage/repository/create_profile_repository.dart';


class CreateProfileFunction {
  final CreateProfileRepository profileRepository;

  CreateProfileFunction(this.profileRepository);

  Future<void> saveProfile({
    required String username,
    required String firstName,
    required String lastName,
    required String zipCode,
    required String phoneNumber,
    required String email,
    required bool emergencyContact,
    required String additionalInfo,
  }) async {
    try {
      await profileRepository.saveProfileToFirestore({
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'zipCode': zipCode,
        'phoneNumber': phoneNumber,
        'email': email,
        'emergencyContact': emergencyContact,
        'additionalInfo': additionalInfo,
      });
    } catch (e) {
      rethrow;
    }
  }
}
