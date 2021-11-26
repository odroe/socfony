bool validateChinaPhone(String phone) => RegExp(r'^1\d{10}$').hasMatch(phone);

String chinaPhoneWrapper(String phone) => '+86$phone';
