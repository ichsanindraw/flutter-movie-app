import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_movie_app/constants/app_constants.dart';

enum HTTPMethod { get, post, put, delete, patch }

class NetworkService {
  Future<T> request<T>(
    String url, {
    required HTTPMethod method,
    required T Function(dynamic) fromJson,
  }) async {
    final Uri uri = Uri.parse(url);

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AppConstants.bearerToken}'
    };

    try {
      final http.Response response;

      switch (method) {
        case HTTPMethod.get:
          response = await http.get(
            uri,
            headers: headers,
          );
          break;

        case HTTPMethod.post:
          response = await http.post(
            uri,
            headers: headers,
          );
          break;

        case HTTPMethod.put:
          response = await http.put(
            uri,
            headers: headers,
          );
          break;

        case HTTPMethod.delete:
          response = await http.delete(
            uri,
            headers: headers,
          );
          break;

        case HTTPMethod.patch:
          response = await http.patch(
            uri,
            headers: headers,
          );
          break;
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return fromJson(data);
      } else {
        throw const HttpException("Failed to load data");
      }
    } on SocketException {
      throw const SocketException("No Internet Connection");
    } catch (e) {
      throw Exception("An unexpected error occurred ${e.toString()}");
    }
  }
}
