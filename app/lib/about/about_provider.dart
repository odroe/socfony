import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Application package info provider.
final AutoDisposeFutureProvider<PackageInfo> applicationPackageInfo =
    FutureProvider.autoDispose<PackageInfo>(
        (Ref ref) => PackageInfo.fromPlatform());
