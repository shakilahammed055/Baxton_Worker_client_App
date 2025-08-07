import 'dart:io';

class ServiceRequestModel {
  String? name;
  String? phone;
  String? email;
  String? city;
  String? postalCode;
  String? locationDesc;
  String? problemDesc;
  String? preferredTime;
  DateTime? preferredDate;
  String? taskTypeId;
  File? reqPhoto;

  ServiceRequestModel({
    this.name,
    this.phone,
    this.email,
    this.city,
    this.postalCode,
    this.locationDesc,
    this.problemDesc,
    this.preferredTime,
    this.preferredDate,
    this.taskTypeId,
    this.reqPhoto,
  });
}
