import 'package:flutter/material.dart';
import 'package:mygovern/Screens/Authentication/signinpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final value = snapshot.data?.getBool("onboard") ?? false;
        if (value) {
          return const SignInpage();
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }
}
