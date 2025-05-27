class ConfirmedTaskModel {
  final String title;
  final String description;
  final String location;
  final String price;
  final DateTime dateTime;
  bool isPaymentCompleted;

  ConfirmedTaskModel({
    required this.title,
    required this.description,
    required this.location,
    required this.price,
    required this.dateTime,
    this.isPaymentCompleted = false,
  });
}
