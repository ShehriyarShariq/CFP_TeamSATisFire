import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/ui/category_widget.dart';
import 'package:satisfire_hackathon/core/ui/loader.dart';
import 'package:satisfire_hackathon/core/ui/no_glow_scroll_behavior.dart';
import 'package:satisfire_hackathon/core/ui/service_widget.dart';
import 'package:satisfire_hackathon/core/ui/upcoming_booking_widget.dart';
import 'package:satisfire_hackathon/features/all_categories/data/models/category.dart';
import 'package:satisfire_hackathon/features/credentials/presentation/pages/sign_in.dart';
import 'package:satisfire_hackathon/features/credentials/presentation/pages/sign_up.dart';
import 'package:satisfire_hackathon/features/customer_dashboard/domain/repositories/customer_dashboard_repository.dart';
import 'package:satisfire_hackathon/features/customer_dashboard/presentation/bloc/bloc/customer_dashboard_bloc.dart';
import 'package:satisfire_hackathon/features/customer_dashboard/presentation/pages/customer_dashboard.dart';
import 'package:satisfire_hackathon/features/provider_dashboard/domain/repositories/provider_dashboard_repository.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/service.dart';

import '../../../../injection_container.dart';

class ProviderDashboard extends StatefulWidget {
  @override
  _ProviderDashboardState createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                margin: const EdgeInsets.all(0),
                child: Container(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Material(
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, right: 10, left: 5),
                              child: Icon(Icons.keyboard_backspace),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        margin: const EdgeInsets.only(bottom: 7),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.1),
                        ),
                      ),
                      Text(
                        FirebaseInit.auth.currentUser.displayName,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFAF42AE),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text(
                  "My Profile",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () {},
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.date_range,
                  color: Colors.black,
                ),
                title: Text(
                  "My Bookings",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal),
                ),
                onTap: () {},
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  "Help and Support",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFFAF42AE),
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.help,
                  color: Colors.black,
                ),
                title: Text(
                  "Help",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () {},
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.star,
                  color: Colors.black,
                ),
                title: Text(
                  "Rate us",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () {},
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.share,
                  color: Colors.black,
                ),
                title: Text(
                  "Share our application",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () {},
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                title: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () async {
                  await sl<ProviderDashboardRepository>().logoutCurrentUser();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerDashboard()),
                      ModalRoute.withName("/"));
                },
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
