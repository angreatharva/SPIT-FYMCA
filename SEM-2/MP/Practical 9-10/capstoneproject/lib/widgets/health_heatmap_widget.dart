import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/health_controller.dart';

class HealthHeatmapWidget extends StatefulWidget {
  final Color primaryColor;
  final Color accentColor;

  const HealthHeatmapWidget({
    Key? key,
    required this.primaryColor,
    required this.accentColor,
  }) : super(key: key);

  @override
  State<HealthHeatmapWidget> createState() => _HealthHeatmapWidgetState();
}

class _HealthHeatmapWidgetState extends State<HealthHeatmapWidget> {
  final HealthController _healthController = Get.find<HealthController>();
  
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime _firstDay = DateTime.now().subtract(const Duration(days: 365));
  DateTime _lastDay = DateTime.now();
  
  Map<DateTime, int> _heatmapData = {};
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  
  @override
  void initState() {
    super.initState();
    _loadHeatmapData();
  }
  
  Future<void> _loadHeatmapData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });
    
    try {
      // Format dates for API
      final startDate = DateFormat('yyyy-MM-dd').format(_firstDay);
      final endDate = DateFormat('yyyy-MM-dd').format(_lastDay);
      
      await _healthController.loadHealthHeatmap(
        startDate: startDate,
        endDate: endDate,
      );
      
      _processHeatmapData();
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
      });
      print('Error loading heatmap data: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  void _processHeatmapData() {
    _heatmapData = {};
    
    try {
      final activities = _healthController.healthHeatmap['activities'] as List?;
      
      if (activities != null) {
        for (var activity in activities) {
          final date = DateTime.parse(activity['date']);
          final score = activity['score'] as int;
          
          _heatmapData[DateTime(date.year, date.month, date.day)] = score;
        }
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Could not process heatmap data: $e';
      });
      print('Error processing heatmap data: $e');
    }
  }
  
  // Function to determine the color based on completion score
  Color _getColorForScore(int score) {
    if (score >= 90) return Colors.green[800]!;
    if (score >= 75) return Colors.green[600]!;
    if (score >= 50) return Colors.green[400]!;
    if (score >= 25) return Colors.green[200]!;
    if (score > 0) return Colors.green[100]!;
    return Colors.grey[300]!;
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: widget.primaryColor,
        ),
      );
    }
    
    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.orange[400], size: Get.width * 0.15),
            SizedBox(height: Get.height * 0.02),
            Text(
              'Could not load health calendar',
              style: TextStyle(
                fontSize: Get.width * 0.045,
                fontWeight: FontWeight.w500,
                color: Colors.orange[800],
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
              child: Text(
                'Calendar data is still being prepared for your account.',
                style: TextStyle(
                  fontSize: Get.width * 0.035,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            ElevatedButton(
              onPressed: _loadHeatmapData,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.06, 
                  vertical: Get.height * 0.015
                ),
              ),
              child: Text(
                'Try Again',
                style: TextStyle(fontSize: Get.width * 0.04),
              ),
            ),
          ],
        ),
      );
    }
    
    // If we have no data but no error, show empty state
    if (_heatmapData.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, color: Colors.grey[400], size: Get.width * 0.15),
            SizedBox(height: Get.height * 0.02),
            Text(
              'No health activity recorded yet',
              style: TextStyle(
                fontSize: Get.width * 0.045,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Text(
              'Complete your daily health tasks to see activity in your calendar',
              style: TextStyle(
                fontSize: Get.width * 0.035,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: [
        _buildCalendar(),
        _buildLegend(),
        if (_selectedDay != null) _buildSelectedDayInfo(),
      ],
    );
  }
  
  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: _firstDay,
      lastDay: _lastDay,
      focusedDay: _focusedDay,
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendTextStyle: const TextStyle().copyWith(color: Colors.red),
        // Make calendar more compact
        cellMargin: EdgeInsets.all(Get.width * 0.005),
        cellPadding: EdgeInsets.zero,
      ),
      daysOfWeekHeight: Get.height * 0.025, // Smaller days of week header
      rowHeight: Get.height * 0.05, // Smaller rows
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          color: widget.accentColor,
          fontWeight: FontWeight.bold,
          fontSize: Get.width * 0.04, // Smaller header text
        ),
        headerPadding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
        headerMargin: EdgeInsets.zero,
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, _) {
          final score = _heatmapData[DateTime(date.year, date.month, date.day)] ?? 0;
          
          return Container(
            margin: EdgeInsets.all(Get.width * 0.005),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getColorForScore(score),
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  fontSize: Get.width * 0.03, // Smaller font size
                  color: score > 50 ? Colors.white : Colors.black87,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildLegend() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.04, 
        vertical: Get.height * 0.005
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: Get.width * 0.01,
        runSpacing: Get.width * 0.01,
        children: [
          _legendItem('None', _getColorForScore(0)),
          _legendItem('1-25%', _getColorForScore(10)),
          _legendItem('26-50%', _getColorForScore(30)),
          _legendItem('51-75%', _getColorForScore(60)),
          _legendItem('76-100%', _getColorForScore(90)),
        ],
      ),
    );
  }
  
  Widget _legendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Get.width * 0.025,
          height: Get.width * 0.025,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: Get.width * 0.005),
        Text(
          label,
          style: TextStyle(
            fontSize: Get.width * 0.025,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(width: Get.width * 0.01),
      ],
    );
  }
  
  Widget _buildSelectedDayInfo() {
    if (_selectedDay == null) return const SizedBox.shrink();
    
    final formattedDate = DateFormat('EEEE, MMM d, yyyy').format(_selectedDay!);
    final score = _heatmapData[DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day)] ?? 0;
    
    return Container(
      margin: EdgeInsets.all(Get.width * 0.03),
      padding: EdgeInsets.all(Get.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Get.width * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            formattedDate,
            style: TextStyle(
              fontSize: Get.width * 0.035,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Get.height * 0.008),
          Row(
            children: [
              SizedBox(
                height: Get.width * 0.075,
                width: Get.width * 0.075,
                child: CircularProgressIndicator(
                  value: score / 100,
                  backgroundColor: Colors.grey[300],
                  color: _getColorForScore(score),
                  strokeWidth: 5,
                ),
              ),
              SizedBox(width: Get.width * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Completion: $score%',
                      style: TextStyle(
                        fontSize: Get.width * 0.032,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      score > 0 
                          ? 'Good job on completing your health tasks!' 
                          : 'No health tasks completed on this day.',
                      style: TextStyle(
                        fontSize: Get.width * 0.028,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 