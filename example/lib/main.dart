import 'package:azure_app_config/azure_remote_service.dart';
import 'package:azure_app_config/models/feature_flag.dart';
import 'package:azure_app_config/models/key_value.dart';
import 'package:example/keys.dart';
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
    service = AzureRemoteService(
      connectionString: AZURE_CONNECTION_STRING,
      loadingStrategy: LoadingStrategy.ONLINE_ALWAYS,
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
          child: Column(
            children: [
              FutureBuilder(
                future: widget.service.getKeyValues(),
                builder: (context, data) {
                  final listTiles = <Widget>[];

                  if (data.hasError) {
                    return Text("${data.error}");
                  }

                  if (data.hasData == false) {
                    return const Text("No Data!");
                  }

                  final List<KeyValue> keyValues = data.data!;

                  final String title =
                      "Total tiles: ${keyValues.length}, ${widget.service.loadingStrategy}";

                  listTiles.add(
                    ListTile(
                      title: Text(title),
                    ),
                  );

                  for (final kv in keyValues) {
                    FeatureFlag? ff = kv.asFeatureFlag();

                    listTiles.add(
                      ListTile(
                        title: Text(kv.key),
                        subtitle: Text(kv.value ?? "No label"),
                        leading: Text(kv.last_modified),
                        trailing: Text(kv.tags.toString()),
                      ),
                    );

                    if (ff != null) {
                      listTiles.add(ListTile(
                        title: Text("${ff.id} => ${ff.description}"),
                        subtitle: Text(ff.conditions.toString()),
                        leading: Text(kv.key),
                        trailing:
                            Switch(value: ff.enabled, onChanged: (val) {}),
                      ));
                    }
                  }

                  return Column(children: listTiles);
                },
              ),
            ],
          ),
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
          FloatingActionButton(
            onPressed: () {
              if (widget.service.loadingStrategy ==
                  LoadingStrategy.ONLINE_ALWAYS) {
                widget.service.switchStrategy(LoadingStrategy.OFFLINE_FIRST);
              } else {
                widget.service.switchStrategy(LoadingStrategy.ONLINE_ALWAYS);
              }
            },
            tooltip: 'Increment',
            child: const Icon(Icons.swap_calls),
          ),
        ],
      ),
    );
  }
}
