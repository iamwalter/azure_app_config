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
  Widget page = const Text("Please select a screen");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(child: Text("Example app")),
            ListTile(
              title: const Text("getKeys"),
              onTap: () {
                setState(() {
                  page = GetKeys(widget.service);
                });
              },
            ),
            ListTile(
              title: const Text("getFeatureFlags"),
              onTap: () {
                setState(() {
                  page = GetFeatureFlags(widget.service);
                });
              },
            ),
            ListTile(
              title: const Text("getKeyValues"),
              onTap: () {
                setState(() {
                  page = GetKeyValues(widget.service);
                });
              },
            ),
            ListTile(
              title: const Text("getFeatureEnabled"),
              onTap: () {
                setState(() {
                  page = GetFeatureEnabled(widget.service);
                });
              },
            ),
            ListTile(
              title: const Text("setKeyValue"),
              onTap: () {
                setState(() {
                  page = SetKeyValue(widget.service);
                });
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: page,
        ),
      ),
    );
  }
}
