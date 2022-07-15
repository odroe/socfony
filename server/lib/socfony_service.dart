import 'package:socfonyapis/socfonyapis.dart';

import 'socfony_service_mixins/access_token.dart';
import 'socfony_service_mixins/moment.dart';
import 'socfony_service_mixins/phone_otp.dart';
import 'socfony_service_mixins/user.dart';

class SocfonyService = SocfonyServiceBase
    with
        AccessTokenMethods,
        PhoneOneTimePasswordMethods,
        UserMethods,
        MomentMethods;
