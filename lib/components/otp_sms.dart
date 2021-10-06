library flutter_otp;

import 'dart:math';
import 'package:sms/sms.dart';

class CustomOtp {
  late int _otp, _minOtpValue, _maxOtpValue;

  void generateOtp([int min = 1000, int max = 9999]) {
    //Generates four digit OTP by default
    _minOtpValue = min;
    _maxOtpValue = max;
    _otp = _minOtpValue + Random().nextInt(_maxOtpValue - _minOtpValue);
  }


  void sendOtp(String phoneNumber,
      [String messageText="Your OTP is : ",
      int min = 1000,
      int max = 9999,
      String countryCode = '+91']) {
    //function parameter 'message' is optional.
    generateOtp(min, max);
    SmsSender sender = new SmsSender();
    String address = (countryCode) + phoneNumber;
    sender.sendSms(new SmsMessage(
        address, messageText + _otp.toString()));
  }

  bool resultChecker(int enteredOtp) {
    //To validate OTP
    return enteredOtp == _otp;
  }
}
