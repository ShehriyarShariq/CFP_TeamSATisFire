import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/ui/InputFieldWidget.dart';
import 'package:satisfire_hackathon/core/ui/no_glow_scroll_behavior.dart';
import 'package:satisfire_hackathon/features/credentials/data/models/credentials_model.dart';
import 'package:satisfire_hackathon/features/credentials/presentation/pages/sign_up.dart';

import 'otp.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();

    _phoneNumberController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height * 0.1)),
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: Image.asset(
                      "img/app_name_alt.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    'Sign In to continue',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.08,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1,
                      bottom: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: InputFieldWidget(
                      controller: _phoneNumberController,
                      leftIcon: Icons.phone,
                      prefixText: "+92 ",
                      defText: "Enter Phone Number",
                      defHintText: "301 1234567",
                      type: 'phoneNum',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      'A 6 digit code will be sent to you via SMS to verify your mobile number.',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        height: 1.3,
                        color: Color(0xFFAF42AE),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  RaisedButton(
                    elevation: 0.5,
                    color: Color(0xFF292C55),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'CONTINUE >',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => OTP(
                          credentials: CredentialsModel(
                            phoneNum:
                                "+92" + _phoneNumberController.text.trim(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Not registered yet? ',
                        style: TextStyle(fontSize: 15, fontFamily: 'Roboto'),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => SignUp())),
                        child: Text(
                          'Create account',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              color: Color(0xFFAF42AE)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
