import 'package:azure_app_config/azure_remote_service.dart';
import 'package:azure_app_config/models/key.dart';

import 'package:flutter/material.dart';

class GetKeys extends StatelessWidget {
  final AzureRemoteService service;

  const GetKeys(this.service, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.getKeys(),
      builder: (context, data) {
        final listTiles = <Widget>[];

        if (data.hasError) {
          return Text("${data.error}");
        }

        if (data.hasData == false) {
          return const Text("No Data!");
        }

        final List<AzureKey> keys = data.data!;

        final String title = "Total tiles: ${keys.length}";

        listTiles.add(
          ListTile(
            title: Text(title),
          ),
        );

        for (final key in keys) {
          listTiles.add(
            ListTile(
              title: Text("${key.toString()}"),
            ),
          );
        }

        return Column(children: listTiles);
      },
    );
  }
}
