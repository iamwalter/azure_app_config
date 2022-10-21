import 'package:azure_app_config/azure_remote_service.dart';
import 'package:azure_app_config/models/feature_flag.dart';

import 'package:flutter/material.dart';

class GetFeatureFlags extends StatelessWidget {
  final AzureRemoteService service;

  const GetFeatureFlags(this.service, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.getFeatureFlags(),
      builder: (context, data) {
        final listTiles = <Widget>[];

        if (data.hasError) {
          return Text("${data.error}");
        }

        if (data.hasData == false) {
          return const Text("No Data!");
        }

        final List<FeatureFlag> featureFlags = data.data!;

        final String title = "Total tiles: ${featureFlags.length}";

        listTiles.add(
          ListTile(
            title: Text(title),
          ),
        );

        for (final ff in featureFlags) {
          listTiles.add(
            ListTile(
              title: Text("${ff.id} => ${ff.description}"),
              subtitle: Text(ff.conditions.toString()),
              trailing: Switch(value: ff.enabled, onChanged: (val) {}),
            ),
          );
        }

        return Column(children: listTiles);
      },
    );
  }
}
