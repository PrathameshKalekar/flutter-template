import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/api_service/error_response.dart';
import '../utils/constants.dart';

class ApiService extends GetConnect implements GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;

  String? token;
  Map<String, String> _mainHeaders = {
    "Content-Type": "application/json; charset=UTF-8",
  };
  ApiService({required this.appBaseUrl, required this.sharedPreferences}) {
    try {
      token = sharedPreferences.getString(Constants.userToken);
      if (kDebugMode) {
        log("********* Token: $token **********", name: "Token");
      }
      _mainHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer $token",
      };
    } catch (e) {
      log("******* ${e.toString()} **********", name: "Error in ApiService()");
    }
  }

  void updateHeader(String? token) {
    _mainHeaders = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token",
    };
  }

  Response handleResponse(Response response) {
    Response _response = response;
    if (_response.hasError && _response.body != null && _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: errorResponse.errors[0].message);
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      }
    } else if (_response.hasError && _response.body == null) {
      log(_response.statusCode.toString(), name: "STATUS CODE");
      _response = const Response(statusCode: 0, statusText: 'Connection to API server failed due to internet connection');
    }
    return _response;
  }

  Future<Response> getRequest(
    String uri,
    String name, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, String>? query,
    Map<String, String>? body,
    Function(dynamic)? decoder,
  }) async {
    try {
      if (kDebugMode) {
        log('====> Get Call: $uri\nToken: $token');
      }
      Response response = await get(
        uri,
        headers: headers ?? _mainHeaders,
        query: query,
        decoder: decoder,
      );
      log("====> API Header: ${headers ?? _mainHeaders}", name: "API Header");
      response = handleResponse(response);
      log("====> API Response: [${response.statusCode}] $uri\n${response.bodyString}", name: name);
      return response;
    } catch (e) {
      log("******* ${e.toString()} **********", name: "Error in getRequest()");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postRequest(
    String uri,
    String name,
    dynamic body, {
    Map<String, String>? headers,
    Map<String, String>? query,
    String? contentType,
    Function(double)? uploadProgress,
    Function(dynamic)? decoder,
  }) async {
    try {
      if (kDebugMode) {
        log('====> Post Call: $uri\nToken: $token');
      }
      Response response = await post(
        uri,
        body,
        headers: headers ?? _mainHeaders,
        query: query,
        contentType: contentType,
        uploadProgress: uploadProgress,
        decoder: decoder,
      );
      log("====> API Header: ${headers ?? _mainHeaders}", name: "API Header");
      response = handleResponse(response);
      log("====> API Response: [${response.statusCode}] $uri\n${response.bodyString}", name: name);
      return response;
    } catch (e) {
      log("******* ${e.toString()} **********", name: "Error in postRequest()");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> putRequest(
    String uri,
    String name,
    dynamic body, {
    Map<String, String>? headers,
    Map<String, String>? query,
    String? contentType,
    Function(double)? uploadProgress,
    Function(dynamic)? decoder,
  }) async {
    try {
      if (kDebugMode) {
        log('====> Put Call: $uri\nToken: $token');
      }
      Response response = await put(uri, body, headers: headers ?? _mainHeaders, query: query, contentType: contentType, uploadProgress: uploadProgress, decoder: decoder);
      log("====> API Header: ${headers ?? _mainHeaders}", name: "API Header");
      response = handleResponse(response);
      log("====> API Response: [${response.statusCode}] $uri\n${response.bodyString}", name: name);
      return response;
    } catch (e) {
      log("******* ${e.toString()} **********", name: "Error in putRequest()");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteRequest(
    String uri,
    String name, {
    Map<String, String>? headers,
    Map<String, String>? query,
    String? contentType,
    Function(dynamic)? decoder,
  }) async {
    try {
      if (kDebugMode) {
        log('====> Delete Call: $uri\nToken: $token');
      }
      Response response = await delete(
        uri,
        headers: headers ?? _mainHeaders,
        query: query,
        contentType: contentType,
        decoder: decoder,
      );
      log("====> API Header: ${headers ?? _mainHeaders}", name: "API Header");
      response = handleResponse(response);
      log("====> API Response: [${response.statusCode}] $uri\n${response.bodyString}", name: name);
      return response;
    } catch (e) {
      log("******* ${e.toString()} **********", name: "Error in deleteRequest()");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> patchRequest(
    String uri,
    String name,
    dynamic body, {
    Map<String, String>? headers,
    Map<String, String>? query,
    String? contentType,
    Function(double)? uploadProgress,
    Function(dynamic)? decoder,
  }) async {
    try {
      if (kDebugMode) {
        log('====> Patch Call: $uri\nToken: $token');
      }
      Response response = await patch(
        uri,
        body,
        headers: headers ?? _mainHeaders,
        query: query,
        contentType: contentType,
        uploadProgress: uploadProgress,
        decoder: decoder,
      );
      log("====> API Header: ${headers ?? _mainHeaders}", name: "API Header");
      response = handleResponse(response);
      log("====> API Response: [${response.statusCode}] $uri\n${response.bodyString}", name: name);
      return response;
    } catch (e) {
      log("******* ${e.toString()} **********", name: "Error in patchRequest()");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
