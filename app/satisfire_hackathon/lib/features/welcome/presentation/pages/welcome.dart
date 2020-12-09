import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/features/credentials/presentation/pages/sign_in.dart';
import 'package:satisfire_hackathon/features/customer_dashboard/presentation/pages/customer_dashboard.dart';
import 'package:satisfire_hackathon/features/provider_dashboard/presentation/pages/provider_dashboard.dart';
import 'package:satisfire_hackathon/features/welcome/domain/repositories/welcome_repository.dart';
import 'package:satisfire_hackathon/features/welcome/presentation/bloc/bloc/welcome_bloc.dart';
import 'package:satisfire_hackathon/injection_container.dart';

import 'onboarding.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  WelcomeBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = sl<WelcomeBloc>();
    Future.delayed(Duration(milliseconds: 200), () {
      _bloc.add(CheckCurrentUserEvent(
          func: () => sl<WelcomeRepository>().checkCurrentUser()));
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return BlocListener(
      cubit: _bloc,
      listener: (context, state) async {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
        );
        if (state is Success) {
          if (state.map['isSignedIn']) {
            if (state.map['isCust']) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => CustomerDashboard()));
            } else {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => ProviderDashboard()));
            }
          } else {
            await FirebaseInit.auth.signInAnonymously();
            // if (await sl<WelcomeRepository>().getIsNewUser()) {
            //   Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(builder: (_) => Onboarding()));
            // } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => CustomerDashboard()));
            // }
          }
        } else if (state is Error) {
          await FirebaseInit.auth.signInAnonymously();
          // if (await sl<WelcomeRepository>().getIsNewUser()) {
          //   Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(builder: (_) => Onboarding()));
          // } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => CustomerDashboard()));
          // }
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF292C55), Color(0xFFAF42AE)],
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.47,
                child: Image.asset(
                  "img/app_name.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.56,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Ghar-baar aur Karobaar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
