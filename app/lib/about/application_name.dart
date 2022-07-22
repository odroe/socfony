import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'about_provider.dart';

const String kApplicationName = 'Socfony';

/// Text widget builder for application name.
Text _applicationNameTextBuilder(
        BuildContext context, String applicationName) =>
    Text(applicationName);

class ApplicationName extends ConsumerWidget {
  const ApplicationName({
    super.key,
    required this.builder,
    this.defaultChild = const Text(kApplicationName),
  });

  const ApplicationName.text({
    super.key,
    this.defaultChild = const Text(kApplicationName),
  }) : builder = _applicationNameTextBuilder;

  /// Child widget builder.
  final Widget Function(BuildContext context, String name) builder;

  /// Default child
  final Widget defaultChild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch package info
    final AsyncValue<PackageInfo> packageInfo =
        ref.watch(applicationPackageInfo);

    // If info is ready, use it to build the widget.
    if (packageInfo.hasValue) {
      return builder(context, packageInfo.value!.appName);
    }

    // Otherwise, use the default child.
    return defaultChild;
  }
}
