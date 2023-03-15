import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/person.dart';
import 'reqres_service.dart';

class ReqresServiceWithHttp implements ReqresService {
  late final http.Client _httpClient;

  ReqresServiceWithHttp() {
    _httpClient = http.Client();
  }
  @override
  Future<Person?> getPerson(BuildContext context, String id) async {
    try {
      final Uri uri = Uri(
        scheme: 'https',
        host: 'reqres.in',
        path: '/api/users/$id',
      );
      final response = await _httpClient.get(uri);
      if (response.statusCode == 200) {
        final responseBody = response.body;
        final responseJson = jsonDecode(responseBody);
        final data = responseJson["data"];
        return Person.fromJson(data);
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Person?> postPerson(
    String firstName,
    String lastName,
    String email,
  ) async {
    try {
      final Uri uri = Uri(
        scheme: 'https',
        host: 'reqres.in',
        path: '/api/users',
      );
      final response = await _httpClient.post(
        uri,
        body: {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
        },
      );
      if (response.statusCode == 201) {
        final responseBody = response.body;
        final data = jsonDecode(responseBody);
        return Person(
          id: int.tryParse(data["id"].toString()) ?? 0,
          name: '${data["first_name"]} ${data["last_name"]}',
          email: data["email"],
        );
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
