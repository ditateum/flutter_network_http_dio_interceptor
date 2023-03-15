import 'package:flutter/material.dart';
import 'package:network_playground/feature_iterceptor/interceptor_page.dart';
import 'package:network_playground/models/person.dart';
import 'package:network_playground/pages/person_list_page.dart';
import 'package:network_playground/widgets/person_card.dart';

import '../services/reqres_service_dio.dart';
import '../services/reqres_service_http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Person? person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            person != null
                ? SizedBox(
                    width: 200,
                    child: PersonCard(person!),
                  )
                : const Text(
                    'no data',
                  ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final result =
                    await ReqresServiceWithHttp().getPerson(context, '2');
                if (result != null) {
                  setState(() {
                    person = result;
                  });
                }
              },
              child: const Text('Get Person with http'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final result =
                    await ReqresServiceWithDio().getPerson(context, '1');
                if (result != null) {
                  setState(() {
                    person = result;
                  });
                }
              },
              child: const Text('Get Person with Dio'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final result = await ReqresServiceWithHttp().postPerson(
                  "dita",
                  "permata",
                  "ditateum@gmail.com",
                );
                if (result != null) {
                  setState(() {
                    person = result;
                  });
                }
              },
              child: const Text('Post Person with http'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final result = await ReqresServiceWithDio().postPerson(
                  "Andrea",
                  "Bizzotto",
                  "andrea@gmail.com",
                );
                if (result != null) {
                  setState(() {
                    person = result;
                  });
                }
              },
              child: const Text('Post Person with Dio'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PersonListPage(),
                ),
              ),
              child: const Text('Get List Data'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InterceptorPage(),
                ),
              ),
              child: const Text('Interceptor Dio'),
            ),
          ],
        ),
      ),
    );
  }
}
