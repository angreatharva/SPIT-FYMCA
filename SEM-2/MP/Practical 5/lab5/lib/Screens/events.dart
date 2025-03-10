import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsPage extends StatefulWidget {
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final List<Map<String, String>> events = [
    {
      "title": "Tech Conference 2025",
      "date": "March 20, 2025",
      "url": "https://mca.spit.ac.in/index.php/notifications/"
    },
    {
      "title": "Flutter Summit",
      "date": "April 15, 2025",
      "url": "https://mca.spit.ac.in/index.php/notifications/"
    },
    {
      "title": "AI Expo",
      "date": "May 10, 2025",
      "url": "https://mca.spit.ac.in/index.php/notifications/"
    },
  ];

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $urlString')),
        );
      }
    } catch (e) {
      debugPrint('Error launching $urlString: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open $urlString')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Upcoming Events"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(event["title"]!, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Date: ${event["date"]}"),
              trailing: Icon(Icons.link, color: Colors.blue),
              onTap: () => _launchURL(event["url"]!),
            ),
          );
        },
      ),
    );
  }
}
