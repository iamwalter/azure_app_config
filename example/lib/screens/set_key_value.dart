import 'package:azure_app_config/azure_app_config.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class SetKeyValue extends StatelessWidget {
  final AzureRemoteService service;

  SetKeyValue(this.service, {super.key});

  final TextEditingController controller = TextEditingController();

  final String _key = "reactiontime";
  final String _label = "CZ";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.getKeyValue(_key, _label),
      builder: (context, data) {
        if (data.hasError) {
          return Text("${data.error}");
        }
        if (data.hasData == false) {
          return const Text("No Data!");
        }

        final KeyValue keyValue = data.data!;

        controller.text = keyValue.value ?? "";

        return Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "$_key => $_label",
              ),
            ),
            MaterialButton(
              color: Colors.orange,
              onPressed: () => save(keyValue),
              child: const Text("Save value!"),
            ),
          ],
        );
      },
    );
  }

  Future<void> save(KeyValue keyValue) async {
    if (controller.text.isEmpty) return;

    await service
        .setKeyValue(
          key: keyValue.key,
          label: keyValue.label ?? "",
          value: controller.text,
          contentType: keyValue.contentType,
          tags: keyValue.tags,
        )
        .then((value) => developer.log("Success!"))
        .onError((error, stackTrace) {
      developer.log("An error occurred while saving");
      developer.log(error.toString());
    });
  }
}
