import 'package:flutter/material.dart';
import '../../models/seat.dart';

class SeatWidget extends StatelessWidget {
  final Seat seat;
  final VoidCallback onTap;

  const SeatWidget({
    Key? key,
    required this.seat,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color seatColor;
    switch (seat.status) {
      case SeatStatus.available:
        seatColor = Colors.white;
        break;
      case SeatStatus.taken:
        seatColor = Colors.grey.shade800;
        break;
      case SeatStatus.selected:
        seatColor = Colors.red;
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: seat.status != SeatStatus.taken
            ? Icon(
          Icons.chair,
          color: seat.status == SeatStatus.selected ? Colors.white : Colors.black,
          size: 20,
        )
            : Icon(Icons.chair,color: Colors.white,),
      ),
    );
  }
}
