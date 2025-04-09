enum SeatStatus {
  available,
  taken,
  selected,
}
class Seat {
  final int number;
  SeatStatus status;

  Seat({
    required this.number,
    this.status = SeatStatus.available,
  });
}