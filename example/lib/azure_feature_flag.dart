// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:azure_app_config/models/feature_flag.dart';
import 'package:azure_app_config/models/key_value.dart';
import 'package:flutter/cupertino.dart';

import 'package:azure_app_config/azure_remote_service.dart';

class AzureKeyList extends StatelessWidget {
  final Widget Function(BuildContext, List<KeyValue>?) builder;

  const AzureKeyList({
    Key? key,
    required this.service,
    required this.builder,
  }) : super(key: key);

  final AzureRemoteService service;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.getKeyValues(),
      builder: ((context, snapshot) => builder.call(context, snapshot.data)),
    );
  }
}

class AzureFeatureFlagList extends StatelessWidget {
  final Widget Function(BuildContext, List<FeatureFlag>?) builder;

  const AzureFeatureFlagList({
    Key? key,
    required this.service,
    required this.builder,
  }) : super(key: key);

  final AzureRemoteService service;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.getFeatureFlags(),
      builder: ((context, snapshot) => builder.call(context, snapshot.data)),
    );
  }
}

class AzureFeatureFlag extends StatelessWidget {
  final AzureRemoteService service;
  final String azureKey, label;

  final Function(BuildContext, bool?) builder;

  const AzureFeatureFlag({
    Key? key,
    required this.azureKey,
    required this.service,
    required this.label,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.getFeatureEnabled(azureKey, label),
      builder: (context, future) => builder.call(context, future.data),
    );
  }
}
