import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'practice_screen.dart';
import 'quiz_screen.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF4A90E2),
          title: const Text('Kids Learning App', style: TextStyle(color: Colors.white, fontSize: 20)),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(icon: Icon(Icons.school), text: 'Practice'),
              Tab(icon: Icon(Icons.quiz), text: 'Quiz'),
              Tab(icon: Icon(Icons.leaderboard), text: 'Leaderboard'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PracticeScreen(),
            QuizScreen(),
            LeaderboardScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
