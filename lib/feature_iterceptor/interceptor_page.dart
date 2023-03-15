import 'package:flutter/material.dart';
import 'package:network_playground/feature_iterceptor/api_service.dart';
import 'package:network_playground/feature_iterceptor/store_service.dart';

class InterceptorPage extends StatefulWidget {
  const InterceptorPage({super.key});

  @override
  State<InterceptorPage> createState() => _InterceptorPageState();
}

class _InterceptorPageState extends State<InterceptorPage> {
  final api = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Header Interceptor'),
      ),
      body: SingleChildScrollView(
        child: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(
              20.0,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () async {
                        final bool result = await api.dioLogin();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'The result of Dio login is $result',
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Dio Login',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        final String result = await api.dioGetData();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'The result of Dio get auth is $result',
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Dio get auth Data',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () async {
                        await StoreService.clear();
                      },
                      child: const Text(
                        'Clear Auth',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
