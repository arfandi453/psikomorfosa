import 'package:firebase_auth/firebase_auth.dart' show ConfirmationResult;
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:universal_html/html.dart' show querySelector;

import '../../../../imports.dart';
import '../../data/phone.dart';

class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String verID;

  const OTPVerificationPage({
    super.key,
    required this.phoneNumber,
    required this.verID,
  });

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final isLoading = false.obs;
  String enteredOTP = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: <Widget>[
          SizedBox(height: 25),
          SizedBox(
            height: context.height / 3,
            child: FlareActor(
              'assets/flare/otp.flr',
              shouldClip: false,
              alignment: Alignment.bottomCenter,
              animation: 'otp',
            ),
          ),
          SizedBox(height: 12),
          AppText(
            t.PhoneVerification,
            size: 22,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
            child: RichText(
              text: TextSpan(
                text: t.EnterCode,
                children: [
                  TextSpan(
                    text: widget.phoneNumber,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: "Nunito",
                    ),
                  ),
                ],
                style: theme.textTheme.subtitle2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            constraints: BoxConstraints(maxWidth: 400),
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              keyboardType: TextInputType.number,
              backgroundColor: Colors.transparent,
              pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
              textStyle: theme.textTheme.headline6,
              onChanged: (v) => enteredOTP = v,
            ),
          ),
          SizedBox(height: 20),
          const Text(
            "Kode OTP berlaku dalam waktu 30 detik \n "
                "Ada Kendala OTP ? Hubungi Di Sini",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: t.DidntRecieveCode,
                  style: TextStyle(
                  color: Colors.grey,
                  fontFamily: "Nunito",
                  ),
                ),
                TextSpan(
                  text: t.RESEND,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pop(context);
                    },
                  style: TextStyle(
                    color: Color(0xFF91D3B3),
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: context.height / 4,
            child: Center(
              child: Obx(
                () => AppButton(
                  t.VERIFY,
                  isLoading: isLoading(),
                  onTap: login,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> login() async {
    if (enteredOTP.length < 6) {
      BotToast.showText(text: t.InvalidSMSCode);
      return;
    }
    isLoading(true);
    try {
      if (kIsWeb) {
        await Get.find<ConfirmationResult>().confirm(enteredOTP);
        querySelector('#__ff-recaptcha-container')?.hidden = true;
      } else {
        await PhoneRepository.login(widget.verID, enteredOTP);
      }
      await authProvider.login();
    } catch (e) {
      BotToast.showText(
        text: AppAuthException.handleError(e).message!,
        duration: Duration(seconds: 3),
      );
    }
    isLoading(false);
  }
}
