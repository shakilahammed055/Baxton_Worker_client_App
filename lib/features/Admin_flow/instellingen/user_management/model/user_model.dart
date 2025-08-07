
// models/user_model.dart
class UserModel {
  final String id;
  final String email;
  final String phone;
  final String name;
  final bool isVerified;
  final String userType;
  final bool active;
  final ClientProfile? clientProfile;
  final WorkerProfile? workerProfile;

  UserModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
    required this.isVerified,
    required this.userType,
    required this.active,
    this.clientProfile,
    this.workerProfile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      name: json['name'] ?? '',
      isVerified: json['isVerified'] ?? false,
      userType: json['UserType'] ?? '',
      active: json['active'] ?? false,
      clientProfile:
          json['clientProfile'] != null
              ? ClientProfile.fromJson(json['clientProfile'])
              : null,
      workerProfile:
          json['workerProfile'] != null
              ? WorkerProfile.fromJson(json['workerProfile'])
              : null,
    );
  }
}

class ClientProfile {
  final String id;
  final String userId;
  final String location;
  final String userName;

  ClientProfile({
    required this.id,
    required this.userId,
    required this.location,
    required this.userName,
  });

  factory ClientProfile.fromJson(Map<String, dynamic> json) {
    return ClientProfile(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      location: json['location'] ?? '',
      userName: json['userName'] ?? '',
    );
  }
}

class WorkerProfile {
  final String id;
  final String userId;
  final String userName;
  final String workerId;
  final String location;
  final String workerSpecialistId;
  final String isActive;

  WorkerProfile({
    required this.id,
    required this.userId,
    required this.userName,
    required this.workerId,
    required this.location,
    required this.workerSpecialistId,
    required this.isActive,
  });

  factory WorkerProfile.fromJson(Map<String, dynamic> json) {
    return WorkerProfile(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      workerId: json['workerId'] ?? '',
      location: json['location'] ?? '',
      workerSpecialistId: json['workerSpecialistId'] ?? '',
      isActive: json['isActive'] ?? '',
    );
  }
}
