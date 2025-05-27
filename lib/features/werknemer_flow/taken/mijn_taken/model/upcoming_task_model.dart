class UpcomingTaskModel {
  final String title;
  final String location;
  final String description;
  final String? date;
  final String? time;
  final String status;

  UpcomingTaskModel({
    required this.title,
    required this.location,
    required this.description,
    this.date,
    this.time,
    required this.status,
  });
}
