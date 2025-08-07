
class Employee {
  final String workerId;
  final String name;
  final String role; // e.g. "Worker", "Manager", etc.
  final String expertise; // e.g. "Plumbing", "Electrical", etc.
  final String imageUrl;

  Employee({
    required this.workerId,
    required this.name,
    required this.role,
    required this.expertise,
    required this.imageUrl,
  });
}
