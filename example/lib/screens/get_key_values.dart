import 'package:azure_app_config/azure_remote_service.dart';
import 'package:azure_app_config/models/feature_flag.dart';
import 'package:azure_app_config/models/key_value.dart';
import 'package:flutter/material.dart';

class GetKeyValues extends StatelessWidget {
  final AzureRemoteService service;

  const GetKeyValues(this.service, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.getKeyValues(),
      builder: (context, data) {
        final listTiles = <Widget>[];

        if (data.hasError) {
          return Text("${data.error}");
        }

        if (data.hasData == false) {
          return const Text("No Data!");
        }

        final List<KeyValue> keyValues = data.data!;

        final String title = "Total tiles: ${keyValues.length}";

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
              trailing: Switch(value: ff.enabled, onChanged: (val) {}),
            ));
          }
        }

        return Column(children: listTiles);
      },
    );
  }
}
