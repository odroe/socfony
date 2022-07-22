import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about_provider.dart';
import 'application_name.dart';
import 'socfony_icon.dart';

/// Contains the about screen.
const Map<String, String> contacts = {
  '耦左科技官网': 'https://odroe.com',
  'Socfony 官网': 'https://socfony.com',
  'GitHub 仓库': 'https://github.com/odroe/socfony',
  '开源联系邮箱':
      'mailto:hello@odroe.com?subject=「OSS」：&body=Hello Odroe OSS group:\n',
  '商务联系邮箱': 'mailto:connect@odroe.com?subject=「BUSINESS」：&body=Hello Odroe:\n',
  '联系电话': 'tel:+86 (28) 8582 0242',
};

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const _ApplicationInfoTile(),
          ...contacts.entries
              .map<Widget>((MapEntry<String, String> entry) =>
                  _urlLauncherTileBuilder(context, entry))
              .toList(),
          const _OpenSourceSoftwareLicenseTile(),
        ],
      ),
    );
  }

  /// URL launcher tile builder.
  Widget _urlLauncherTileBuilder(
      BuildContext context, MapEntry<String, String> entry) {
    return _UrlLauncherTile(
      title: entry.key,
      url: entry.value,
    );
  }
}

class _OpenSourceSoftwareLicenseTile extends ConsumerWidget {
  const _OpenSourceSoftwareLicenseTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch package info.
    final AsyncValue<PackageInfo> packageInfo =
        ref.watch(applicationPackageInfo);

    return ListTile(
      title: const Text('使用的开源软件的许可证'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => showLicensePage(
        context: context,
        useRootNavigator: true,
        applicationIcon: const SocfonyIcon(),
        applicationName: packageInfo.value?.appName,
        applicationVersion: packageInfo.value?.version,
      ),
    );
  }
}

class _ApplicationInfoTile extends StatelessWidget {
  const _ApplicationInfoTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const ApplicationName.text(),
      subtitle: const _ApplicationVersion(),
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(
          'assets/socfony.svg',
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _ApplicationVersion extends ConsumerWidget {
  const _ApplicationVersion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<PackageInfo> packageInfo =
        ref.watch(applicationPackageInfo);

    return packageInfo.when<Widget>(
      data: (PackageInfo info) => Text('Version ${info.version}'),
      error: (_, __) => const Text('Unknown'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

/// URL launcher tile.
class _UrlLauncherTile extends StatelessWidget {
  const _UrlLauncherTile({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  final String title;
  final String url;

  Uri get uri => Uri.parse(url);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(_subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: _launcher,
    );
  }

  /// Tile subtitle.
  String get _subtitle {
    if (RegExp(r'^https?').hasMatch(uri.scheme)) {
      return uri.host + uri.path;
    }

    return Uri.decodeComponent(uri.path);
  }

  /// Launch URL.
  void _launcher() => launchUrl(uri);
}
