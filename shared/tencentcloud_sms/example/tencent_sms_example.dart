import 'package:tencentcloud_sms/src/actions/send/send.dart';
import 'package:tencentcloud_sms/tencentcloud_sms.dart';

class VerificationCodeMessageOptions extends SendTencentCloudSMSOptions {
  @override
  Future<List<String>> get phoneNumberSet async => ['+86177****8434'];

  @override
  Future<String> get templateId async => '617248';

  @override
  Future<List<String>> get templateParamSet async => ['1234', '5'];

  @override
  Future<String?> get signName async => '耦左科技';
}

void main() async {
  TencentCloudSMS.init(
    secretId: 'AKIDzjEE2bnyoSI1bxk3k******',
    secretKey: 'oNrAHwTgeT2ZruqX2MR******',
    appId: '1400473840',
  );

  VerificationCodeMessageOptions options = VerificationCodeMessageOptions();
  try {
    var response = await TencentCloudSMS.send(options);
  print(response.request!.headers);
  print(response.body);
  } catch (e) {
    print(e.toString());
  
  }
}
