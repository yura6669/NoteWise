import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notewise/firebase_options.dart';
import 'package:notewise/modules/resorses/app_colors.dart';

class NoteWiseApp extends StatelessWidget {
  const NoteWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _firebaseError(context);
        } else {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('Hello World!'),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _firebaseError(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Database initialization error',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Future<FirebaseApp> _initializeApp() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAnalytics.instance;
    return firebaseApp;
  }
}
