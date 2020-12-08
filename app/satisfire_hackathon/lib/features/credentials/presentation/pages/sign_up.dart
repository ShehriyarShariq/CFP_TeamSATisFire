import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/ui/InputFieldWidget.dart';
import 'package:satisfire_hackathon/core/ui/no_glow_scroll_behavior.dart';
import 'package:satisfire_hackathon/features/credentials/data/models/credentials_model.dart';
import 'package:satisfire_hackathon/features/credentials/presentation/pages/sign_in.dart';

import 'otp.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _nameController, _phoneNumberController;
  bool _isCustomer = true;

  @override
  void initState() {
    super.initState();

    _nameController = new TextEditingController();
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
                      top: (MediaQuery.of(context).size.height * 0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5, right: 5),
                          child: Text(
                            "Become a part of our ",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Image.asset(
                            "img/app_name_alt.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    'Register a new account',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildTabToggler(),
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1,
                      bottom: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Column(
                      children: [
                        InputFieldWidget(
                          controller: _nameController,
                          leftIcon: Icons.assignment_ind,
                          prefixText: "",
                          defText: "Enter Your Name",
                          defHintText: "John Doe",
                          type: 'name',
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        InputFieldWidget(
                          controller: _phoneNumberController,
                          leftIcon: Icons.phone,
                          prefixText: "+92 ",
                          defText: "Enter Phone Number",
                          defHintText: "301 1234567",
                          type: 'phoneNum',
                        ),
                      ],
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
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => OTP(
                        credentials: CredentialsModel(
                          isCustomer: _isCustomer,
                          name: _nameController.text.trim(),
                          phoneNum: "+92" + _phoneNumberController.text.trim(),
                        ),
                      ),
                    )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Already registered? ',
                        style: TextStyle(fontSize: 15, fontFamily: 'Roboto'),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => SignIn())),
                        child: Text(
                          'Sign In',
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

  Widget _buildTabToggler() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 35,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (!_isCustomer) {
                      setState(() {
                        _isCustomer = true;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          _isCustomer ? Color(0xFFAF42AE) : Colors.transparent,
                      border: Border(
                          bottom:
                              BorderSide(width: 2, color: Color(0xFFAF42AE))),
                    ),
                    child: Center(
                      child: Text(
                        "I want to learn",
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Roboto',
                            color: _isCustomer ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (_isCustomer) {
                      setState(() {
                        _isCustomer = false;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          !_isCustomer ? Color(0xFFAF42AE) : Colors.transparent,
                      border: Border(
                          bottom:
                              BorderSide(width: 2, color: Color(0xFFAF42AE))),
                    ),
                    child: Center(
                      child: Text(
                        "I want to work",
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Roboto',
                            color: !_isCustomer ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
