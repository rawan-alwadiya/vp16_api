import 'dart:io';

import 'package:flutter/material.dart';
import 'package:api_app/models/api_response.dart';
import 'package:api_app/prefs/shared_pref_controller.dart';

mixin ApiHelper {
  ApiResponse get errorResponse =>
      ApiResponse(message: 'Something went wrong', success: false);

  Map<String,String> get headers {
    return {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: SharedPrefController().getValueFor(key: PrefKeys.token.name)!,
    };
  }
}