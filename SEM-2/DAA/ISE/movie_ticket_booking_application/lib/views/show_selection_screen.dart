import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/show_controller.dart';
import '../models/movie.dart';
import '../models/show.dart';
import '../widgets/show_time_card.dart';
import 'seat_selection_screen.dart';

class ShowSelectionScreen extends StatefulWidget {
  final Movie movie;

  const ShowSelectionScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<ShowSelectionScreen> createState() => _ShowSelectionScreenState();
}

class _ShowSelectionScreenState extends State<ShowSelectionScreen> {
  final ShowController _showController = ShowController();
  late Future<List<Show>> _showsFuture;
  DateTime _selectedDate = DateTime.now();
  int _selectedDateIndex = 0;

  @override
  void initState() {
    super.initState();
    _showsFuture = _showController.getShowsByMovie(widget.movie.id);
  }

  List<DateTime> _getNext7Days() {
    return List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
  }

  List<Show> _getShowsForSelectedDate(List<Show> shows) {
    final selectedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
   print("selectedDate: $selectedDate");
    return shows.where((show) {
      final showDate = DateFormat('yyyy-MM-dd').format(show.date);
      return showDate == selectedDate;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final next7Days = _getNext7Days();

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Show'),
      ),
      body: Column(
        children: [
          // Date Selector
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: next7Days.length,
              itemBuilder: (context, index) {
                final date = next7Days[index];
                final isSelected = _selectedDateIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = date;
                      _selectedDateIndex = index;
                    });
                  },
                  child: Container(
                    width: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('E').format(date),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateFormat('d').format(date),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Shows List
          Expanded(
            child: FutureBuilder<List<Show>>(
              future: _showsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No shows available for this movie'));
                } else {
                  final showsForSelectedDate = _getShowsForSelectedDate(snapshot.data!);

                  if (showsForSelectedDate.isEmpty) {
                    return const Center(child: Text('No shows available for selected date'));
                  }

                  // Group by theatre
                  final Map<String, List<Show>> showsByTheatre = {};
                  for (var show in showsForSelectedDate) {
                    final theatreName = show.theatre?.name ?? 'Unknown Theatre';
                    if (!showsByTheatre.containsKey(theatreName)) {
                      showsByTheatre[theatreName] = [];
                    }
                    showsByTheatre[theatreName]!.add(show);
                  }

                  return ListView.builder(
                    itemCount: showsByTheatre.length,
                    itemBuilder: (context, index) {
                      final theatreName = showsByTheatre.keys.elementAt(index);
                      final theatreShows = showsByTheatre[theatreName]!;
                      final location = theatreShows.first.theatre?.location ?? '';

                      return Card(
                        margin: const EdgeInsets.all(10),
                        color: const Color(0xFF222222),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                theatreName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (location.isNotEmpty)
                                Text(
                                  location,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              const SizedBox(height: 15),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: theatreShows.map((show) {
                                  return ShowTimeCard(
                                    time: show.time,
                                    price: show.price,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SeatSelectionScreen(show: show),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
