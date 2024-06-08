import 'package:feast_mobile/features/auth/profile_welcome_page/profile_welcome_page.dart';
import 'package:flutter/material.dart';

class ProfileBasePage extends StatelessWidget {
  const ProfileBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final authVm = context.watch<AuthVM>();
    return ProfileWelcomePage();
  }
}
