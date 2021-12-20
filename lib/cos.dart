import 'package:crypto/crypto.dart';
import 'package:single/single.dart';

import 'configuration.dart';

// Generate a COS sign list
String sign({
  required String method,
  required String key,
  String? query,
  Map<String, String>? headers,
}) {
  // Get options.
  final options = single<Configuration>().tencentCloudCos;

  // Get the current time.
  final now = DateTime.now();

  // Get expired at time.
  final expiredAt = now.add(Duration(minutes: 30));

  // Get need to siggn key.
  final _signKeyData =
      '${now.millisecondsSinceEpoch ~/ 1000};${expiredAt.millisecondsSinceEpoch ~/ 1000}';
  final singKey = Hmac(sha1, options.secretKey.codeUnits)
      .convert(_signKeyData.codeUnits)
      .toString();

  // Generate url params list and sort.
  final List<String> urlParamsList =
      query?.split('&').map((e) => e.split('=')[0]).toList() ?? <String>[];
  urlParamsList.sort();
  // Generate url params map
  final Map<String, String> urlParamsMap = Map<String, String>.fromEntries(
    query
            ?.split('&')
            .map((e) => e.split('='))
            .map((e) => MapEntry(e[0], e.length == 1 ? '' : e[1])) ??
        <MapEntry<String, String>>[],
  );

  // Using key sort url params map.
  final Map<String, String> sortedUrlParamsMap = Map.fromEntries(
    urlParamsMap.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
  );

  // Genrate headers list and sort.
  final headerList = headers?.keys.toList() ?? <String>[];
  headerList.sort();

  // Using key sort headers map.
  final Map<String, String> sortedHeadersMap = Map.fromEntries(
    (headers?.entries.toList()?..sort((a, b) => a.key.compareTo(b.key))) ??
        <MapEntry<String, String>>[],
  );

  // Generate http string.
  final httpString = [
        method.toLowerCase(),
        key,
        sortedUrlParamsMap.entries.map((e) => '${e.key}=${e.value}').join('&'),
        sortedHeadersMap.entries.map((e) => '${e.key}:${e.value}').join('&'),
      ].join('\n') +
      '\n';

  // Generate string to sign.
  final stringToSign = [
        'sha1',
        _signKeyData,
        sha1.convert(httpString.codeUnits).toString(),
      ].join('\n') +
      '\n';

  // Generate signature.
  final signature =
      Hmac(sha1, singKey.codeUnits).convert(stringToSign.codeUnits).toString();

  // Generate params.
  final params = <MapEntry<String, String>>[
    MapEntry('q-sign-algorithm', 'sha1'),
    MapEntry('q-ak', options.secretId),
    MapEntry('q-sign-time', _signKeyData),
    MapEntry('q-key-time', _signKeyData),
    MapEntry('q-header-list', headerList.join(';')),
    MapEntry('q-url-param-list', urlParamsList.join(';')),
    MapEntry('q-signature', signature),
    ...urlParamsMap.entries,
  ];

  return Uri(
    scheme: 'https',
    host: options.domain,
    path: key,
    queryParameters: Map.fromEntries(params),
  ).toString();
}

main() {
  final result = sign(
    method: 'get',
    key: '/socfony.png',
  );

  print(result);
}
