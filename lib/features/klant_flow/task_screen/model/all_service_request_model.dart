// To parse this JSON data, do
//
//     final allservicerequest = allservicerequestFromJson(jsonString);

import 'dart:convert';

Allservicerequest allservicerequestFromJson(String str) => Allservicerequest.fromJson(json.decode(str));

String allservicerequestToJson(Allservicerequest data) => json.encode(data.toJson());

class Allservicerequest {
    String id;
    DateTime createdAt;
    DateTime updatedAt;
    String name;
    String phoneNumber;
    String email;
    String city;
    String postalCode;
    String note;
    dynamic serviceDetailsId;
    String locationDescription;
    String problemDescription;
    DateTime preferredTime;
    DateTime preferredDate;
    String status;
    int basePrice;
    dynamic adminProfileId;
    String workerProfileId;
    String invoiceId;
    String clientProfileId;
    String taskTypeId;
    String paymentType;
    int rating;
    dynamic review;
    bool accept;
    ClientProfile clientProfile;
    WorkerProfile workerProfile;
    dynamic adminProfile;
    List<Task> tasks;
    List<Photo> afterPhoto;
    List<Photo> beforePhoto;
    Invoice invoice;
    dynamic reviews;
    dynamic signature;
    List<ServiceDetail> serviceDetails;
    TaskType taskType;
    ReqPhoto reqPhoto;

    Allservicerequest({
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.name,
        required this.phoneNumber,
        required this.email,
        required this.city,
        required this.postalCode,
        required this.note,
        required this.serviceDetailsId,
        required this.locationDescription,
        required this.problemDescription,
        required this.preferredTime,
        required this.preferredDate,
        required this.status,
        required this.basePrice,
        required this.adminProfileId,
        required this.workerProfileId,
        required this.invoiceId,
        required this.clientProfileId,
        required this.taskTypeId,
        required this.paymentType,
        required this.rating,
        required this.review,
        required this.accept,
        required this.clientProfile,
        required this.workerProfile,
        required this.adminProfile,
        required this.tasks,
        required this.afterPhoto,
        required this.beforePhoto,
        required this.invoice,
        required this.reviews,
        required this.signature,
        required this.serviceDetails,
        required this.taskType,
        required this.reqPhoto,
    });

    factory Allservicerequest.fromJson(Map<String, dynamic> json) => Allservicerequest(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        city: json["city"],
        postalCode: json["postalCode"],
        note: json["note"],
        serviceDetailsId: json["serviceDetailsId"],
        locationDescription: json["locationDescription"],
        problemDescription: json["problemDescription"],
        preferredTime: DateTime.parse(json["preferredTime"]),
        preferredDate: DateTime.parse(json["preferredDate"]),
        status: json["status"],
        basePrice: json["basePrice"],
        adminProfileId: json["AdminProfileId"],
        workerProfileId: json["workerProfileId"],
        invoiceId: json["invoiceId"],
        clientProfileId: json["clientProfileId"],
        taskTypeId: json["taskTypeId"],
        paymentType: json["paymentType"],
        rating: json["rating"],
        review: json["review"],
        accept: json["accept"],
        clientProfile: ClientProfile.fromJson(json["ClientProfile"]),
        workerProfile: WorkerProfile.fromJson(json["WorkerProfile"]),
        adminProfile: json["AdminProfile"],
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
        afterPhoto: List<Photo>.from(json["afterPhoto"].map((x) => Photo.fromJson(x))),
        beforePhoto: List<Photo>.from(json["beforePhoto"].map((x) => Photo.fromJson(x))),
        invoice: Invoice.fromJson(json["Invoice"]),
        reviews: json["Reviews"],
        signature: json["signature"],
        serviceDetails: List<ServiceDetail>.from(json["serviceDetails"].map((x) => ServiceDetail.fromJson(x))),
        taskType: TaskType.fromJson(json["TaskType"]),
        reqPhoto: ReqPhoto.fromJson(json["reqPhoto"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "city": city,
        "postalCode": postalCode,
        "note": note,
        "serviceDetailsId": serviceDetailsId,
        "locationDescription": locationDescription,
        "problemDescription": problemDescription,
        "preferredTime": preferredTime.toIso8601String(),
        "preferredDate": preferredDate.toIso8601String(),
        "status": status,
        "basePrice": basePrice,
        "AdminProfileId": adminProfileId,
        "workerProfileId": workerProfileId,
        "invoiceId": invoiceId,
        "clientProfileId": clientProfileId,
        "taskTypeId": taskTypeId,
        "paymentType": paymentType,
        "rating": rating,
        "review": review,
        "accept": accept,
        "ClientProfile": clientProfile.toJson(),
        "WorkerProfile": workerProfile.toJson(),
        "AdminProfile": adminProfile,
        "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
        "afterPhoto": List<dynamic>.from(afterPhoto.map((x) => x.toJson())),
        "beforePhoto": List<dynamic>.from(beforePhoto.map((x) => x.toJson())),
        "Invoice": invoice.toJson(),
        "Reviews": reviews,
        "signature": signature,
        "serviceDetails": List<dynamic>.from(serviceDetails.map((x) => x.toJson())),
        "TaskType": taskType.toJson(),
        "reqPhoto": reqPhoto.toJson(),
    };
}

class Photo {
    String id;
    DateTime createdAt;
    String filename;
    String originalFilename;
    dynamic caption;
    String path;
    String url;
    String fileType;
    String mimeType;
    int size;
    dynamic serviceRequestId;
    String? serviceAfterId;
    dynamic clientProfileId;
    dynamic workerProfileId;
    dynamic serviceSignatureId;
    dynamic messageId;
    String? beforePhotoId;
    dynamic reportPhotoId;
    dynamic adminProfileId;

    Photo({
        required this.id,
        required this.createdAt,
        required this.filename,
        required this.originalFilename,
        required this.caption,
        required this.path,
        required this.url,
        required this.fileType,
        required this.mimeType,
        required this.size,
        required this.serviceRequestId,
        required this.serviceAfterId,
        required this.clientProfileId,
        required this.workerProfileId,
        required this.serviceSignatureId,
        required this.messageId,
        required this.beforePhotoId,
        required this.reportPhotoId,
        required this.adminProfileId,
    });

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        filename: json["filename"],
        originalFilename: json["originalFilename"],
        caption: json["caption"],
        path: json["path"],
        url: json["url"],
        fileType: json["fileType"],
        mimeType: json["mimeType"],
        size: json["size"],
        serviceRequestId: json["serviceRequestId"],
        serviceAfterId: json["serviceAfterId"],
        clientProfileId: json["clientProfileId"],
        workerProfileId: json["workerProfileId"],
        serviceSignatureId: json["ServiceSignatureId"],
        messageId: json["messageId"],
        beforePhotoId: json["beforePhotoId"],
        reportPhotoId: json["reportPhotoId"],
        adminProfileId: json["adminProfileId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "filename": filename,
        "originalFilename": originalFilename,
        "caption": caption,
        "path": path,
        "url": url,
        "fileType": fileType,
        "mimeType": mimeType,
        "size": size,
        "serviceRequestId": serviceRequestId,
        "serviceAfterId": serviceAfterId,
        "clientProfileId": clientProfileId,
        "workerProfileId": workerProfileId,
        "ServiceSignatureId": serviceSignatureId,
        "messageId": messageId,
        "beforePhotoId": beforePhotoId,
        "reportPhotoId": reportPhotoId,
        "adminProfileId": adminProfileId,
    };
}

class ClientProfile {
    String id;
    String userId;
    String location;
    String userName;

    ClientProfile({
        required this.id,
        required this.userId,
        required this.location,
        required this.userName,
    });

    factory ClientProfile.fromJson(Map<String, dynamic> json) => ClientProfile(
        id: json["id"],
        userId: json["userId"],
        location: json["location"],
        userName: json["userName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "location": location,
        "userName": userName,
    };
}

class Invoice {
    String id;
    String invoiceNumber;
    String clientProfileId;
    String workerProfileId;
    String bankInfoId;
    DateTime dateIssued;
    DateTime duaDate;
    String invoiceStatus;
    int totalAmount;
    dynamic companyId;

    Invoice({
        required this.id,
        required this.invoiceNumber,
        required this.clientProfileId,
        required this.workerProfileId,
        required this.bankInfoId,
        required this.dateIssued,
        required this.duaDate,
        required this.invoiceStatus,
        required this.totalAmount,
        required this.companyId,
    });

    factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        invoiceNumber: json["invoiceNumber"],
        clientProfileId: json["clientProfileId"],
        workerProfileId: json["workerProfileId"],
        bankInfoId: json["bankInfoId"],
        dateIssued: DateTime.parse(json["dateIssued"]),
        duaDate: DateTime.parse(json["duaDate"]),
        invoiceStatus: json["invoiceStatus"],
        totalAmount: json["totalAmount"],
        companyId: json["companyId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "invoiceNumber": invoiceNumber,
        "clientProfileId": clientProfileId,
        "workerProfileId": workerProfileId,
        "bankInfoId": bankInfoId,
        "dateIssued": dateIssued.toIso8601String(),
        "duaDate": duaDate.toIso8601String(),
        "invoiceStatus": invoiceStatus,
        "totalAmount": totalAmount,
        "companyId": companyId,
    };
}

class ReqPhoto {
    String url;

    ReqPhoto({
        required this.url,
    });

    factory ReqPhoto.fromJson(Map<String, dynamic> json) => ReqPhoto(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}

class ServiceDetail {
    String id;
    String serviceRequestId;
    String serviceName;
    int servicePrice;

    ServiceDetail({
        required this.id,
        required this.serviceRequestId,
        required this.serviceName,
        required this.servicePrice,
    });

    factory ServiceDetail.fromJson(Map<String, dynamic> json) => ServiceDetail(
        id: json["id"],
        serviceRequestId: json["serviceRequestId"],
        serviceName: json["serviceName"],
        servicePrice: json["servicePrice"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "serviceRequestId": serviceRequestId,
        "serviceName": serviceName,
        "servicePrice": servicePrice,
    };
}

class TaskType {
    String name;

    TaskType({
        required this.name,
    });

    factory TaskType.fromJson(Map<String, dynamic> json) => TaskType(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class Task {
    String id;
    String name;
    int price;
    String serviceRequestId;
    String clientId;
    String workerId;
    bool done;
    DateTime createdAt;
    DateTime updatedAt;

    Task({
        required this.id,
        required this.name,
        required this.price,
        required this.serviceRequestId,
        required this.clientId,
        required this.workerId,
        required this.done,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        serviceRequestId: json["serviceRequestId"],
        clientId: json["clientId"],
        workerId: json["workerId"],
        done: json["done"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "serviceRequestId": serviceRequestId,
        "clientId": clientId,
        "workerId": workerId,
        "done": done,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class WorkerProfile {
    String id;
    String userId;
    String userName;
    String workerId;
    String location;
    String workerSpecialistId;
    String isActive;

    WorkerProfile({
        required this.id,
        required this.userId,
        required this.userName,
        required this.workerId,
        required this.location,
        required this.workerSpecialistId,
        required this.isActive,
    });

    factory WorkerProfile.fromJson(Map<String, dynamic> json) => WorkerProfile(
        id: json["id"],
        userId: json["userId"],
        userName: json["userName"],
        workerId: json["workerId"],
        location: json["location"],
        workerSpecialistId: json["workerSpecialistId"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userName": userName,
        "workerId": workerId,
        "location": location,
        "workerSpecialistId": workerSpecialistId,
        "isActive": isActive,
    };
}
