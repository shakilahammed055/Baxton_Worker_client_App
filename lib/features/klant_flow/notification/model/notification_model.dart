class NotificationModel {
  final String id;
  final String title;
  final String body;
  final NotificationData data;
  final bool read;
  final DateTime time;
  final String userId;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.data,
    required this.read,
    required this.time,
    required this.userId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      data: NotificationData.fromJson(json['data']),
      read: json['read'],
      time: DateTime.parse(json['time']),
      userId: json['userId'],
    );
  }
}

class NotificationData {
  final String type;
  final String message;
  final String clientName;
  final ClientProfile clientProfile;
  final String serviceRequestId;
  final String serviceRequestName;

  NotificationData({
    required this.type,
    required this.message,
    required this.clientName,
    required this.clientProfile,
    required this.serviceRequestId,
    required this.serviceRequestName,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      type: json['type'] ?? '',
      message: json['message'] ?? '',
      clientName: json['clientName'] ?? '',
      clientProfile: ClientProfile.fromJson(json['clientProfile']),
      serviceRequestId: json['serviceRequestId'] ?? '',
      serviceRequestName: json['serviceRequestName'] ?? '',
    );
  }
}

class ClientProfile {
  final String id;
  final String url;
  final String filename;
  final String mimeType;
  final DateTime createdAt;

  ClientProfile({
    required this.id,
    required this.url,
    required this.filename,
    required this.mimeType,
    required this.createdAt,
  });

  factory ClientProfile.fromJson(Map<String, dynamic> json) {
    return ClientProfile(
      id: json['id'],
      url: json['url'],
      filename: json['filename'],
      mimeType: json['mimeType'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
