import 'dart:convert';
import 'dart:io';
import 'package:baxton/features/klant_flow/task_screen/model/submit_task_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class TaskSubmitRepository {
  Future<SubmitTaskResponse> submitTask({
    required String taskId,
    required File signatureFile,
    required int rating,
    required String review,
    required String token,
  }) async {
    final uri = Uri.parse(
      'https://freepik.softvenceomega.com/ts/task/submit?id=$taskId',
    );

    final request =
        http.MultipartRequest('POST', uri)
          ..headers.addAll({'Authorization': 'Bearer $token', 'accept': '*/*'})
          ..fields['rating'] = rating.toString()
          ..fields['review'] = review;

    final mimeType = lookupMimeType(signatureFile.path)?.split('/');
    if (mimeType != null && mimeType.length == 2) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'signature',
          signatureFile.path,
          contentType: MediaType(mimeType[0], mimeType[1]),
        ),
      );
    }

    final response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      final json = jsonDecode(responseBody);
      return SubmitTaskResponse.fromJson(json);
    } else {
      throw Exception('Failed to submit task: ${response.statusCode}');
    }
  }
}
