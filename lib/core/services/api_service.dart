import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopee/shared/data/models/api_response_model.dart';

class ApiService {
  Future<ApiResponseModel> getRequest(
      {required String endpoint,
      Map<String, String>? headers,
      String? param}) async {
    var _uri = Uri.parse('$endpoint?$param');
    var res = await http.get(_uri, headers: headers);
    var apiResponse = ApiResponseModel(
      body: jsonDecode(res.body),
      message: res.reasonPhrase,
      statusCode: res.statusCode,
    );

    return apiResponse;
  }

  Future<ApiResponseModel> postRequest(String endpoint,
      {required Map<String, dynamic> body,
      required Map<String, String> headers}) async {
    var _uri = Uri.parse(endpoint);
    var res = await http.post(
      _uri,
      headers: headers,
      body: jsonEncode(body),
    );

    var apiResponse = ApiResponseModel(
      body: res.body,
      message: res.reasonPhrase,
      statusCode: res.statusCode,
    );
    // print(apiResponse.toMap());
    return apiResponse;
  }

  Future<ApiResponseModel> deleteRequest({
    required String endpoint,
    Map<String, String>? headers,
    String? param,
  }) async {
    var _uri = Uri.parse('$endpoint?$param');
    var res = await http.delete(_uri, headers: headers);
    var apiResponse = ApiResponseModel(
      body: jsonDecode(res.body),
      message: res.reasonPhrase,
      statusCode: res.statusCode,
    );

    return apiResponse;
  }
}
