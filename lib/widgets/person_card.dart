import 'package:flutter/material.dart';

import '../models/person.dart';

class PersonCard extends StatelessWidget {
  const PersonCard(this.person, {super.key});
  final Person person;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(person.name),
      subtitle: Text(person.email),
    );
  }
}
