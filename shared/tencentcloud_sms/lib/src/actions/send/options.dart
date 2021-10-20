part of 'send.dart';

abstract class SendTencentCloudSMSOptions {
  Future<String> get templateId;
  Future<String?> get signName async => null;
  Future<List<String>> get templateParamSet;
  Future<List<String>> get phoneNumberSet;
  Future<String?>? get extendCode async => null;
  Future<String?>? get sessionContext async => null;
  Future<String?>? get senderId async => null;

  Future<Map<String, dynamic>> toJson(TencentCloudSMSSendAction action) async => {
    'PhoneNumberSet': await phoneNumberSet,
    'SmsSdkAppId': action.client.appId,
    'TemplateId': await templateId,
    'SignName': await signName,
    'TemplateParamSet': await templateParamSet,
    // 'ExtendCode': await extendCode,
    // 'SessionContext': await sessionContext,
    // 'SenderId': await senderId,
  };
}
