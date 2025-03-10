import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  List<String> _numbers = List.generate(11, (index) => index.toString());
  List<String> _alphabets = List.generate(26, (index) => String.fromCharCode(65 + index));
  List<String> _currentList = [];
  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _initializeTts();
  }

  void _initializeTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
  }

  void _speakText(String text) async {
    await _flutterTts.speak(text);
  }

  void _loadNumbers() {
    setState(() {
      _currentList = _numbers;
      _selectedCategory = 'Numbers';
    });
  }

  void _loadAlphabets() {
    setState(() {
      _currentList = _alphabets;
      _selectedCategory = 'Alphabets';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_selectedCategory.isEmpty) ...[
                Text(
                  'Practice Numbers & Alphabets',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _loadNumbers,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('Practice Numbers', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _loadAlphabets,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('Practice Alphabets', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ] else ...[
                Text(
                  'Practicing $_selectedCategory',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _currentList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _speakText(_currentList[index]), // Speak on tap
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              _currentList[index],
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategory = '';
                      _currentList = [];
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('Back', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}
