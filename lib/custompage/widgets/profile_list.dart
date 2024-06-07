import 'package:flutter/material.dart';
import 'package:dogs_sitting/models/user_profile.dart';
import 'package:dogs_sitting/custompage/widgets/profile_list_item.dart';

class ProfileList extends StatelessWidget {
  final List<UserProfile> profiles;

  const ProfileList({super.key, required this.profiles});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/123.png',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Positioned.fill(
          child: ListView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              UserProfile profile = profiles[index];
              return ProfileListItem(
                profile: profile,
              );
            },
          ),
        ),
      ],
    );
  }
}
