import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/person.dart';

abstract class ReqresService {
  Future<Person?> getPerson(BuildContext context, String id);
  Future<Person?> postPerson(
    String firstName,
    String lastName,
    String email,
  );
}
