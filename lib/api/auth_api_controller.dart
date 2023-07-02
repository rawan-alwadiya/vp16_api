import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:api_app/api/api_settings.dart';
import 'package:api_app/models/api_response.dart';
import 'package:api_app/models/student.dart';
import 'package:api_app/prefs/shared_pref_controller.dart';
import 'package:api_app/utils/api_helper.dart';

class AuthApiController with ApiHelper{
  /// 1) Generate URI
  /// 2) Execute http.method(uri, body: {})
  ///     => get, post, put/patch, delete
  /// 3) Check response state (success, failure)
  /// 4) in case of success
  ///   1) decode json body from string to json
  ///   2) convert map to suitable model
  ///   3) do required actions towards converted data in case of needed
  /// 5) return request result to UI (Presentation Layer)

  Future<ApiResponse> login(
      {required String email, required String password}) async {
    Uri uri = Uri.parse(ApiSettings.login);
    var response = await http.post(uri, body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Student student = Student.fromJson(jsonResponse['object']);
        //TODO: save student data to SharedPreferences
        await SharedPrefController().save(student);
      }

      return ApiResponse(
          message: jsonResponse['message'], success: jsonResponse['status']);
    }
    return errorResponse;
  }

  Future<ApiResponse> register(Student student)async{
    Uri uri = Uri.parse(ApiSettings.register);
    var response = await http.post(uri, body: {
      'full_name': student.fullName,
      'email': student.email,
      'password': student.password,
      'gender': student.gender,
    });
    if(response.statusCode == 201 || response.statusCode == 400){
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'],
          success: jsonResponse['status']);
    }
    return errorResponse;
  }

  Future<ApiResponse> logout() async{
    Uri uri = Uri.parse(ApiSettings.logout);
    var response = await http.get(uri, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader
          : SharedPrefController().getValueFor(key: PrefKeys.token.name)?? ''
    });
    if(response.statusCode == 200 || response.statusCode == 401){
      SharedPrefController().clear();
      return ApiResponse(message: 'Logged out successfully', success: true);
    }
    return errorResponse;
  }
}
