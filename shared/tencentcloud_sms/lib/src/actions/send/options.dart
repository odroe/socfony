part of 'send.dart';

abstract class SendTencentCloudSMSOptions {
  /// Get template id.
  Future<String> get templateId;

  /// Get sms sign name.
  Future<String?> get signName async => null;

  /// Get template params.
  Future<List<String>> get templateParamSet;

  /// Get phone number.
  Future<List<String>> get phoneNumberSet;

  /// Get extend code.
  Future<String?>? get extendCode async => null;

  /// Get sexxsion context.
  Future<String?>? get sessionContext async => null;

  /// Get sender id.
  Future<String?>? get senderId async => null;

  /// Convert to tencent cloud sms options map.
  /// 
  /// [action] Tencent cloud sms send action.
  Future<Map<String, dynamic>> toMap(TencentCloudSMSSendAction action) async {
    // create options map.
    final result = <String, dynamic>{
      'PhoneNumberSet': await phoneNumberSet,
      'SmsSdkAppId': action.client.appId,
      'TemplateId': await templateId,
      'SignName': await signName,
      'TemplateParamSet': await templateParamSet,
    };

    // add extend code.
    final _extendCode = await extendCode;
    if (_extendCode != null) {
      result['ExtendCode'] = _extendCode;
    }

    // add sender id.
    final _senderId = await senderId;
    if (_senderId != null) {
      result['SenderId'] = _senderId;
    }

    // add session context.
    final _sessionContext = await sessionContext;
    if (_sessionContext != null) {
      result['SessionContext'] = _sessionContext;
    }

    return result;
  }
}
