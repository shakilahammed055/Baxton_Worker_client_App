// To parse this JSON data, do
//
//     final taskoverview = taskoverviewFromJson(jsonString);

import 'dart:convert';

Taskoverview taskoverviewFromJson(String str) => Taskoverview.fromJson(json.decode(str));

String taskoverviewToJson(Taskoverview data) => json.encode(data.toJson());

class Taskoverview {
    Data data;
    String message;
    bool success;

    Taskoverview({
        required this.data,
        required this.message,
        required this.success,
    });

    factory Taskoverview.fromJson(Map<String, dynamic> json) => Taskoverview(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "success": success,
    };
}

class Data {
    List<Completed> requested;
    List<Completed> confirmed;
    List<Completed> completed;

    Data({
        required this.requested,
        required this.confirmed,
        required this.completed,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        requested: List<Completed>.from(json["requested"].map((x) => Completed.fromJson(x))),
        confirmed: List<Completed>.from(json["confirmed"].map((x) => Completed.fromJson(x))),
        completed: List<Completed>.from(json["completed"].map((x) => Completed.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "requested": List<dynamic>.from(requested.map((x) => x.toJson())),
        "confirmed": List<dynamic>.from(confirmed.map((x) => x.toJson())),
        "completed": List<dynamic>.from(completed.map((x) => x.toJson())),
    };
}

class Completed {
    TaskType taskType;
    String id;
    String problemDescription;
    String city;
    String locationDescription;
    DateTime preferredDate;
    DateTime preferredTime;
    String status;

    Completed({
        required this.taskType,
        required this.id,
        required this.problemDescription,
        required this.city,
        required this.locationDescription,
        required this.preferredDate,
        required this.preferredTime,
        required this.status,
    });

    factory Completed.fromJson(Map<String, dynamic> json) => Completed(
        taskType: TaskType.fromJson(json["TaskType"]),
        id: json["id"],
        problemDescription: json["problemDescription"],
        city: json["city"],
        locationDescription: json["locationDescription"],
        preferredDate: DateTime.parse(json["preferredDate"]),
        preferredTime: DateTime.parse(json["preferredTime"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "TaskType": taskType.toJson(),
        "id": id,
        "problemDescription": problemDescription,
        "city": city,
        "locationDescription": locationDescription,
        "preferredDate": preferredDate.toIso8601String(),
        "preferredTime": preferredTime.toIso8601String(),
        "status": status,
    };
}

class TaskType {
    String id;
    String name;

    TaskType({
        required this.id,
        required this.name,
    });

    factory TaskType.fromJson(Map<String, dynamic> json) => TaskType(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
