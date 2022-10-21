// ignore_for_file: unused_import

import 'package:azure_app_config/azure_remote_service.dart';
import 'package:azure_app_config/models/feature_flag.dart';
import 'package:azure_app_config/models/key_value.dart';
import 'package:example/screens/get_feature_enabled.dart';
import 'package:example/screens/get_key_values.dart';
import 'package:example/screens/get_keys.dart';
import 'package:example/screens/get_feature_flags.dart';
import 'package:example/screens/set_key_value.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  late final AzureRemoteService service;

  MyHomePage({super.key, required this.title}) {
    final connectionString = dotenv.env["CONNECTION_STRING"];

    service = AzureRemoteService(
      connectionString: connectionString ?? "",
    );
  }

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          // child: GetKeys(widget.service),
          // child: GetFeatureFlags(widget.service),
          // child: GetKeyValues(widget.service),
          // child: GetFeatureEnabled(widget.service),
          child: SetKeyValue(widget.service),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {});
            },
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
