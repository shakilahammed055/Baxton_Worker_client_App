class SubmitTaskResponse {
  final bool success;
  final String message;
  final Map<String, dynamic> data;

  SubmitTaskResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SubmitTaskResponse.fromJson(Map<String, dynamic> json) {
    return SubmitTaskResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }
}
