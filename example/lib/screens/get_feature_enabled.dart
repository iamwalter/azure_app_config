import 'package:azure_app_config/azure_remote_service.dart';
import 'package:flutter/material.dart';

class GetFeatureEnabled extends StatelessWidget {
  final AzureRemoteService service;

  const GetFeatureEnabled(this.service, {super.key});

  @override
  Widget build(BuildContext context) {
    final key = "chat_feature";
    final label = "JUST";
    return FutureBuilder(
      future: service.getFeatureEnabled(key, label),
      builder: (context, data) {
        if (data.hasError) {
          return Text("${data.error}");
        }

        if (data.hasData == false) {
          return const Text("No Data!");
        }

        final bool enabled = data.data!;

        final String title = "key: $key, label: $label, enabled: $enabled";

        if (enabled) {
          return Column(children: [
            Text(title),
            const Placeholder(),
          ]);
        } else {
          return Column(children: [Text(title)]);
        }
      },
    );
  }
}
