import 'package:flutter/material.dart';
import 'package:safe_guinee/services/accounts/auth.dart';
import 'package:safe_guinee/ui/screen/accounts/sign_in_screen.dart';
import 'package:safe_guinee/ui/screen/home_screen.dart';

class RedirectionPage extends StatefulWidget {
  const RedirectionPage({super.key});

  @override
  State<RedirectionPage> createState() => _RedirectionPageState();
}

class _RedirectionPageState extends State<RedirectionPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().userChanges, 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data != null) {
          // User is signed in, redirect to home screen
          return const HomeScreen();
        } else {
          // User is not signed in, redirect to onboarding or sign-in screen
          return const SignInScreen();
        }
      }
    );
  }
}