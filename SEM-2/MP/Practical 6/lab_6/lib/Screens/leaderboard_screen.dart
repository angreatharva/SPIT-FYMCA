import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  final List<Map<String, dynamic>> _leaderboard = const [
    {'name': 'Atharva', 'score': 100},
    {'name': 'Abhishek', 'score': 90},
    {'name': 'Abhijeet', 'score': 85},
    {'name': 'Adam', 'score': 80},
    {'name': 'Vineet', 'score': 75},
    {'name': 'Darshan', 'score': 70},
    {'name': 'Kiran', 'score': 65},
    {'name': 'Ram', 'score': 60},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text('Leaderboard'),
        backgroundColor: Color(0xFFFFA726),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Top Performers',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _leaderboard.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        _leaderboard[index]['name'],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${_leaderboard[index]['score']} pts',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
