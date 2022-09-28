import 'package:azure_app_config/azure_remote_service.dart';
import 'package:example/azure_feature_flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");

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
    final credential = dotenv.env['CREDENTIAL'];
    final secret = dotenv.env["SECRET"]; // Value
    const host = "https://ac-cz-test-eigenrisico.azconfig.io";

    service = AzureRemoteService(
      host: host,
      credential: credential ?? "",
      secret: secret ?? "",
      loadingStrategy: LoadingStrategy.OFFLINE_FIRST,
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
              AzureFeatureFlagList(
                  service: widget.service,
                  builder: (context, data) {
                    final widgets = <Widget>[];

                    if (data == null) {
                      return const Text("No feature flags!");
                    }

                    for (final ff in data) {
                      widgets.add(ListTile(
                        title: Text(ff.id),
                        subtitle: Text(ff.conditions.toString()),
                        leading: Text(ff.description),
                        trailing:
                            Switch(value: ff.enabled, onChanged: (val) {}),
                      ));
                    }

                    return Column(children: widgets);
                  }),
              AzureKeyList(
                service: widget.service,
                builder: (context, keyValues) {
                  final listTiles = <Widget>[];

                  if (keyValues == null) {
                    return Text("No Data!");
                  }

                  listTiles.add(ListTile(
                    title: Text("Total tiles: ${keyValues.length}"),
                  ));

                  for (final kv in keyValues) {
                    listTiles.add(
                      ListTile(
                        title: Text(kv.key),
                        subtitle: Text(kv.value ?? "No label"),
                        leading: Text(kv.last_modified),
                      ),
                    );
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
