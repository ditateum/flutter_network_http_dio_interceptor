import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/person.dart';
import '../widgets/error_dialog.dart';
import 'reqres_service.dart';

class ReqresServiceWithDio implements ReqresService {
  Future<List<Person>?> getListPerson(BuildContext context) async {
    try {
      final Uri uri = Uri(
        scheme: 'https',
        host: 'reqres.in',
        path: '/api/users',
        queryParameters: {
          "page": "2",
        },
      );
      final response = await Dio().getUri(uri);
      if (response.statusCode == 200) {
        final data = response.data["data"];
        final List<Person> listPerson = List<Person>.from(
          data.map((person) => Person.fromJson(person)),
        );
        return listPerson;
      }
      return null;
    } catch (e) {
      errorDialog(context, e.toString());
    }
    return null;
  }

  @override
  Future<Person?> getPerson(BuildContext context, String id) async {
    try {
      final Uri uri = Uri(
        scheme: 'https',
        host: 'reqres.in',
        path: '/api/users/$id',
      );
      final response = await Dio().getUri(uri);
      if (response.statusCode == 200) {
        final data = response.data;
        return Person.fromJson(data["data"]);
      }
      return null;
    } catch (e) {
      errorDialog(context, e.toString());
    }
    return null;
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
      final response = await Dio().post(
        '$uri',
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
        },
      );
      if (response.statusCode == 201) {
        final data = response.data;
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
