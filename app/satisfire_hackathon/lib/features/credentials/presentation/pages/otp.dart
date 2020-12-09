import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/ui/InputFieldWidget.dart';
import 'package:satisfire_hackathon/core/ui/no_glow_scroll_behavior.dart';
import 'package:satisfire_hackathon/features/credentials/data/models/credentials_model.dart';
import 'package:satisfire_hackathon/features/credentials/presentation/bloc/bloc/credentials_bloc.dart';
import 'package:satisfire_hackathon/features/credentials/presentation/pages/sign_up.dart';
import 'package:satisfire_hackathon/features/customer_dashboard/presentation/pages/customer_dashboard.dart';
import 'package:satisfire_hackathon/features/provider_dashboard/presentation/pages/provider_dashboard.dart';

import '../../../../injection_container.dart';

import 'package:satisfire_hackathon/core/ui/loader.dart';
import 'package:satisfire_hackathon/core/ui/overlay_loader.dart'
    as OverlayLoader;

class OTP extends StatefulWidget {
  final CredentialsModel credentials;

  const OTP({Key key, this.credentials}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  CredentialsBloc _bloc;
  TextEditingController _firstDigitController,
      _secondDigitController,
      _thirdDigitController,
      _fourthDigitController,
      _fifthDigitController,
      _sixthDigitController;

  FocusNode _first, _second, _third, _fourth, _fifth, _sixth;

  String _actualCode = "";

  @override
  void initState() {
    super.initState();

    _firstDigitController = new TextEditingController();
    _secondDigitController = new TextEditingController();
    _thirdDigitController = new TextEditingController();
    _fourthDigitController = new TextEditingController();
    _fifthDigitController = new TextEditingController();
    _sixthDigitController = new TextEditingController();

    _first = new FocusNode();
    _second = new FocusNode();
    _third = new FocusNode();
    _fourth = new FocusNode();
    _fifth = new FocusNode();
    _sixth = new FocusNode();

    _bloc = sl<CredentialsBloc>();
    _bloc.add(SendCodeEvent());

    sendVerificationCode();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder(
                cubit: _bloc,
                builder: (context, state) {
                  if (state is Initial || state is SendingCode) {
                    return Center(
                      child: Loader(),
                    );
                  }

                  return _buildBody(context);
                },
              ),
            ),
          ),
        ),
        BlocBuilder(
          cubit: _bloc,
          builder: (context, state) {
            if (state is Processing) {
              return OverlayLoader.Overlay();
            }

            return Container();
          },
        ),
      ],
    );
  }

  ScrollConfiguration _buildBody(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height * 0.1)),
              width: MediaQuery.of(context).size.width * 0.47,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Image.asset("img/app_name_alt.png"),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Material(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            right: 20,
                            bottom: 10,
                          ),
                          child: Text(
                            "< Back",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Enter the 6 digit code sent to you via SMS",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _digitInputWidget(_firstDigitController, _first, _second),
                  _digitInputWidget(_secondDigitController, _second, _third),
                  _digitInputWidget(_thirdDigitController, _third, _fourth),
                  _digitInputWidget(_fourthDigitController, _fourth, _fifth),
                  _digitInputWidget(_fifthDigitController, _fifth, _sixth),
                  _digitInputWidget(
                      _sixthDigitController, _sixth, new FocusNode()),
                ],
              ),
            ),
            SizedBox(
              height: 30,
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
              onPressed: () {
                String code = getCode();
                if (code.length == 6) _signInWithPhoneNumber(code);
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _digitInputWidget(
      TextEditingController controller, FocusNode current, FocusNode next) {
    return Container(
      height: 60,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Color(0xFFAF42AE),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(40 * 0.2),
          child: AutoSizeTextField(
            controller: controller,
            onChanged: (String value) async {
              if (value.length == 1) {
                FocusScope.of(context).requestFocus(next);
              }
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "8",
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.2),
              ),
              contentPadding: const EdgeInsets.only(
                top: 0,
                left: 0,
                right: 0,
                bottom: 2,
              ),
            ),
            focusNode: current,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 100,
              color: Color(0xFFAF42AE),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
          ),
        ),
      ),
    );
  }

  String getCode() {
    return _firstDigitController.text +
        _secondDigitController.text +
        _thirdDigitController.text +
        _fourthDigitController.text +
        _fifthDigitController.text +
        _sixthDigitController.text;
  }

  void sendVerificationCode() {
    FirebaseInit.auth.verifyPhoneNumber(
      phoneNumber: widget.credentials.phoneNum,
      timeout: Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  codeSent(String verificationId, [int forceResendingToken]) async {
    _actualCode = verificationId;
    print("codeSent(): $verificationId");
    _bloc.add(CodeSentEvent());
    Fluttertoast.showToast(
        msg: "Code Sent",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  codeAutoRetrievalTimeout(String verificationId) {
    _actualCode = verificationId;
    print("codeAutoRetrievalTimeout(): $verificationId");
  }

  verificationFailed(FirebaseAuthException authException) {
    print("verificationFailed(): ${authException.message}");
  }

  verificationCompleted(AuthCredential auth) {
    _bloc.add(VerifyingCodeEvent());
    FirebaseInit.auth.signInWithCredential(auth).then((UserCredential value) {
      if (value.user != null) {
        Fluttertoast.showToast(
            msg: "Successfully Logged In",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[700],
            textColor: Colors.white,
            fontSize: 16.0);
        authenticationSuccessful(value.user);
      } else {
        Fluttertoast.showToast(
            msg: "Failed to verify code",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[700],
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
      }
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Failed to verify code",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    });
  }

  void _signInWithPhoneNumber(String smsCode) async {
    _bloc.add(VerifyingCodeEvent());
    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _actualCode, smsCode: smsCode);
    print("ACTUAL CODE: " + _actualCode);
    print("CODE: " + smsCode);
    await FirebaseInit.auth
        .signInWithCredential(_authCredential)
        .then((UserCredential user) async {
      if (user != null) {
        Fluttertoast.showToast(
            msg: "Successfully Logged In",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[700],
            textColor: Colors.white,
            fontSize: 16.0);
        authenticationSuccessful(user.user);
      } else {
        Fluttertoast.showToast(
            msg: "Some error occurred",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[700],
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
      }
    }).catchError((error) {
      print("WTHH: $error");
      Fluttertoast.showToast(
          msg: "Failed to verify code",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    });
  }

  Future<void> authenticationSuccessful(User user) async {
    await FirebaseInit.dbRef
        .child("customer/${user.uid}")
        .once()
        .then((snapshot) async {
      if (snapshot.value == null) {
        await FirebaseInit.dbRef
            .child("provider/${user.uid}")
            .once()
            .then((providerSnapshot) async {
          if (providerSnapshot.value == null) {
            await user.updateProfile(displayName: widget.credentials.name);
            await FirebaseInit.dbRef
                .child((widget.credentials.isCustomer
                        ? "customer/"
                        : "provider/") +
                    FirebaseInit.auth.currentUser.uid)
                .set({
              'name': widget.credentials.name.toLowerCase(),
              'phoneNum': widget.credentials.phoneNum,
            });

            await FirebaseInit.fcm
                .subscribeToTopic(FirebaseInit.auth.currentUser.uid);

            if (widget.credentials.isCustomer) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => CustomerDashboard()));
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => ProviderDashboard()));
            }
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => ProviderDashboard()));
          }
        });
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => CustomerDashboard()));
      }
    });
  }
}
