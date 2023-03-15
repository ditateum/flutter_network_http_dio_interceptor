import 'package:flutter/material.dart';
import 'package:network_playground/models/person.dart';
import 'package:network_playground/widgets/person_card.dart';

import '../services/reqres_service_dio.dart';

class PersonListPage extends StatefulWidget {
  const PersonListPage({super.key});

  @override
  State<PersonListPage> createState() => _PersonListPageState();
}

class _PersonListPageState extends State<PersonListPage> {
  List<Person>? persons;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => getListPerson());
  }

  getListPerson() async {
    isLoading = true;
    final results = await ReqresServiceWithDio().getListPerson(context);
    setState(() {
      persons = results;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person List'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : persons == null
              ? const Center(
                  child: Text('No Data'),
                )
              : ListView.builder(
                  itemCount: persons!.length,
                  itemBuilder: (context, index) {
                    final person = persons![index];
                    return PersonCard(person);
                  },
                ),
    );
  }
}
