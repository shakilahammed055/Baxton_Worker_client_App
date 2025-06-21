// lib/features/Admin_flow/betalingsbeheer/model/invoice_model.dart
enum PaymentStatus { pending, confirmed, overdue }

class Invoice {
  final String invoiceNumber;
  final String customerName;
  final String taskName;
  final String amount;
  final String date;
  final PaymentStatus status;

  Invoice({
    required this.invoiceNumber,
    required this.customerName,
    required this.taskName,
    required this.amount,
    required this.date,
    required this.status,
  });
}

// class TaskStatsModel {
//   final double assigned;
//   final double inProgress;
//   final double completed;
//   final double overdue;
//   final int unassigned;

//   TaskStatsModel({
//     required this.assigned,
//     required this.inProgress,
//     required this.completed,
//     required this.overdue,
//     required this.unassigned,
//   });
// }

class TaskModel {
  String assignedTo;
  String expertise;
  String status;
  String amount;

  TaskModel({
    required this.assignedTo,
    required this.expertise,
    required this.status,
    required this.amount,
  });
}
