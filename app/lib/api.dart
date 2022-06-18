import 'dart:convert';

import 'package:http/http.dart' as http;

import 'configurations.dart';

/// API endpoint http authorization token reader.
typedef TokenReader = Future<String?> Function();

/// Create a GraphQL request.
///
/// - [tokenReader] is the authorization token reader.
Future<http.Request> createRequest([TokenReader? tokenReader]) async {
  final http.Request request = http.Request('POST', Uri.parse(apiEndpoint));

  /// Get authorization token.
  final String? token = await tokenReader?.call();
  if (token != null) {
    request.headers['authorization'] = token;
  }

  /// Set headers.
  request.headers.addAll({
    'accept': 'application/json',
    'content-type': 'application/json',
  });

  /// Return request.
  return request;
}

/// Send a GraphQL query/mutation request.
///
/// - [query] is the GraphQL query/mutation.
/// - [operationName] is the operation name.
/// - [variables] is the variables.
Future<T> request<T>({
  required String query,
  String? operationName,
  Map<String, dynamic>? variables,
  TokenReader? tokenReader,
  http.Request? request,
  http.Client? client,
  required T Function(http.Response) parser,
}) async {
  /// Create client.
  client ??= http.Client();

  /// Resolve or create a request.
  request ??= await createRequest(tokenReader);

  /// Set GraphQL query body.
  request.body = json.encode({
    'query': query,
    if (operationName != null) 'operationName': operationName,
    if (variables != null) 'variables': variables,
  });

  /// Send request, get response.
  final http.Response response = await http.Response.fromStream(
    await client.send(request),
  );

  return parser(response);
}

Map<String, dynamic> dynamicBodyResponseParser(http.Response response) {
  /// Decode response body.
  final Map<String, dynamic> body = json.decode(response.body);

  /// Get data and errors
  final Map<String, dynamic>? data = body['data'] as Map<String, dynamic>?;
  final List<dynamic>? errors = body['errors'] as List<dynamic>?;

  /// Check if there are errors.
  if (errors != null && errors.isNotEmpty) {
    for (final item in errors) {
      throw ErrorCodeException(item['message']);
    }
  } else if (data == null || data.isEmpty) {
    throw FormatException('Invalid response.', response);
  }

  return data!;
}

T bodyResponseParserWith<T>(
    http.Response response, T Function(Map<String, dynamic>) parser) {
  return parser(dynamicBodyResponseParser(response));
}

class ErrorCodeException implements Exception {
  final String errorcode;

  const ErrorCodeException(this.errorcode);

  @override
  String toString() => errorcode;
}
