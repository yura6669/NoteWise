import 'package:flutter/material.dart';
import 'package:notewise/core/models/user.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  static const routeName = 'home';
  const HomeScreen({
    required this.user,
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
