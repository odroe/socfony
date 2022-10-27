import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';

import 'chmod.dart' as chmod;

final Logger logger = Logger.standard();

/// Get protobuf latest version failed.
Never throwFetchProtobufVersionFailed() {
  logger.stderr('Get protobuf latest version failed.');

  throw Exception('Failed to fetch protobuf version');
}

/// Fetch https://github.com/protocolbuffers/protobuf lastest release version.
Future<String> getProtibufLatestVersion() async {
  final Progress progress = logger.progress('Fetching protobuf version');
  final Uri url = Uri.https(
      'api.github.com', '/repos/protocolbuffers/protobuf/releases/latest');

  final Response response = await get(url);
  if (response.statusCode != 200) {
    throwFetchProtobufVersionFailed();
  }

  final Map<String, dynamic> json = jsonDecode(response.body);
  final String tagName = json['tag_name'] as String;
  final RegExp versionRegExp = RegExp(r'.*?(\d+\.\d+).*?');
  final String? version = versionRegExp.firstMatch(tagName)?.group(1);

  if (version == null) {
    throwFetchProtobufVersionFailed();
  }

  progress.finish(showTiming: true);

  return version;
}

/// Get protobuf supported platform.
String getProtobufPlatform() {
  if (Platform.isMacOS) {
    if (Platform.version.contains('arm64')) {
      return 'osx-aarch_64';
    }

    return 'osx-x86_64';
  } else if (Platform.isLinux) {
    if (Platform.version.contains('arm64')) {
      return 'linux-aarch_64';
    }

    return 'linux-x86_64';
  } else if (Platform.isWindows) {
    return 'win64';
  }

  throw Exception('Unsupported platform');
}

/// Get protobuf download url.
Uri getProtobufDownloadUrl(String version, String platform) {
  // https://github.com/protocolbuffers/protobuf/releases/download/v{version}/protoc-{version}-{os}.zip
  return Uri.https('github.com',
      '/protocolbuffers/protobuf/releases/download/v$version/protoc-$version-$platform.zip');
}

/// Build store path.
String buildStorePath(String version, String platform, String path) {
  final current = joinAll([dirname(Platform.script.path), '..']);
  final dir =
      joinAll([current, '.dart_tool', 'protobuf', '$platform-$version', path]);

  return relative(dir);
}

Future<String> main() async {
  final String version = await getProtibufLatestVersion();
  final String platform = getProtobufPlatform();
  final Uri url = getProtobufDownloadUrl(version, platform);
  final String executable = buildStorePath(version, platform, 'bin/protoc');

  // Lookfile
  final File lookfile = File(buildStorePath(version, platform, '.lookfile'));
  if (lookfile.existsSync() && File(executable).existsSync()) {
    return executable;
  }

  // logger.stdout('Downloading protobuf $version for $platform...');
  final Progress progress =
      logger.progress('Downloading protobuf $version for $platform');
  final Client client = Client();
  final Request request = Request('GET', url);
  final StreamedResponse response = await client.send(request);
  final File archive =
      File(buildStorePath(version, platform, basename(url.path)));
  if (archive.existsSync()) {
    archive.deleteSync();
  }
  archive.createSync(recursive: true);

  final IOSink sink = archive.openWrite();

  // Download protobuf archive.
  await response.stream.pipe(sink);
  await sink.flush();
  await sink.close();
  client.close();

  progress.finish(showTiming: true);

  // Extract protobuf archive.
  final Progress extractProgress = logger.progress('Extracting protobuf');
  final InputFileStream archiveStream = InputFileStream(archive.path);
  final directory = ZipDirectory.read(archiveStream);
  for (final ZipFileHeader fileHeader in directory.fileHeaders) {
    final String path = buildStorePath(version, platform, fileHeader.filename);
    if (fileHeader.file is ZipFile) {
      final File outoput = File(path);
      if (outoput.existsSync()) {
        outoput.deleteSync();
      }
      outoput.createSync(recursive: true);
      outoput.writeAsBytesSync(fileHeader.file!.content);
    }
  }

  lookfile.createSync();
  extractProgress.finish(showTiming: true);
  chmod.main([executable]);

  return executable;
}
