class TaskStats {
  final int assigned;
  final int inProgress;
  final int completed;
  final int overdue;
  int unassigned;

  TaskStats({
    required this.assigned,
    required this.inProgress,
    required this.completed,
    required this.overdue,
    required this.unassigned,
  });

  int get total => assigned + inProgress + completed + overdue + unassigned;
}

class TaskRequest {
  final String title;
  final String user;
  final String timeAgo;

  TaskRequest({required this.title, required this.user, required this.timeAgo});
}
