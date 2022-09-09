// import 'package:easysms/easysms.dart' as easysms;

// /// Tencent Cloud sdhort message service geteway.
// const easysms.Geteway kTencentCloudSdhortMessageServiceGeteway =
//     easysms.TencentCloudGeteway(
//   appId: '1400473840',
//   secretId: 'AKIDVptiLinb9QQ9dqJ0TgcHfmcARSCfqkOl',
//   secretKey: '8zauwhCQN2QYPyGI3XkhMkrhHZaJlwqS',
// );

// /// Send phone one-time password sms options.
// const SendOtpSmsOptions kSendOtpSmsOptions = SendOtpSmsOptions(
//   signName: '耦左科技',
//   templateId: '617248',
//   params: [
//     '{otp}',
//     '{minutes}',
//   ],
// );

import 'package:rc/rc.dart';

class Configure {
  const Configure(this.rc);

  /// Current runtime configuration.
  final RuntimeConfiguration rc;

  /// Get database url.
  String? get databaseUrl => rc('DATABASE_URL');
}

Configure get configure => Configure(
      RuntimeConfiguration.from('.env', includeEnvironment: true),
    );
