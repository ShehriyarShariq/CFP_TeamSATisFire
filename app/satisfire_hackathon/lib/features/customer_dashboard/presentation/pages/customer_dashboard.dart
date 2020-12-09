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
import 'package:satisfire_hackathon/features/service_details/data/models/service.dart';

import '../../../../injection_container.dart';

class CustomerDashboard extends StatefulWidget {
  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CustomerDashboardBloc _categoriesBloc, _servicesBloc;

  List<Category> categories = [];
  List<Service> popularServices = [];

  @override
  void initState() {
    super.initState();

    _categoriesBloc = sl<CustomerDashboardBloc>();
    _servicesBloc = sl<CustomerDashboardBloc>();

    _categoriesBloc.add(LoadAllCategoriesEvent(
        func: sl<CustomerDashboardRepository>().getLimitedCategories));
    _servicesBloc.add(LoadPopularServicesEvent(
        func: sl<CustomerDashboardRepository>().getPopularServices));
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
                        FirebaseInit.auth.currentUser.isAnonymous
                            ? "Guest"
                            : FirebaseInit.auth.currentUser.displayName,
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
              if (!FirebaseInit.auth.currentUser.isAnonymous) ...[
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
              ],
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
              if (!FirebaseInit.auth.currentUser.isAnonymous) ...[
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
                    await sl<CustomerDashboardRepository>().logoutCurrentUser();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerDashboard()),
                        ModalRoute.withName("/"));
                  },
                ),
              ],
              SizedBox(
                height: 40,
              ),
              if (FirebaseInit.auth.currentUser.isAnonymous)
                ListTile(
                  title: Text(
                    "Start your business with us",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFAF42AE),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SignUp(),
                      ),
                    );
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
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.06),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 17,
                ),
                child: SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Icon(
                          Icons.menu,
                          size: 30,
                        ),
                      ),
                      Image.asset(
                        "img/app_name_alt.png",
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome, ${FirebaseInit.auth.currentUser.isAnonymous ? "Guest" : FirebaseInit.auth.currentUser.displayName}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.05),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Color(0xFFAF42AE),
                        size: 22,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            controller: TextEditingController(),
                            decoration: InputDecoration(
                              hintText: 'What do you want to learn?',
                              hintStyle:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 0)),
                            ),
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: NoGlowScrollBehavior(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.33,
                            child: BlocBuilder(
                              cubit: _categoriesBloc,
                              builder: (context, state) {
                                if (state is Initial ||
                                    state is LoadingCategories) {
                                  return Center(
                                    child: Loader(),
                                  );
                                } else if (state is LoadedCategories) {
                                  categories.clear();
                                  categories.addAll(state.categories);
                                }

                                if (categories.isEmpty) {
                                  return Center(
                                    child: Text(
                                      "No Categories Available",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  itemCount: categories.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      CategoryWidget(
                                    category: categories[index],
                                  ),
                                );
                              },
                            )),
                        if (!FirebaseInit.auth.currentUser.isAnonymous) ...[
                          SizedBox(
                            height: 25,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Upcoming Bookings",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "View All",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFAF42AE),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 1,
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                UpComingBookingWidget(),
                          ),
                        ],
                        SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Services",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "View All",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFAF42AE),
                                ),
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder(
                          cubit: _servicesBloc,
                          builder: (context, state) {
                            if (state is Initial || state is LoadingServices) {
                              return Center(
                                child: Loader(),
                              );
                            } else if (state is LoadedServices) {
                              popularServices.clear();
                              popularServices.addAll(state.services);
                            }

                            if (categories.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    "No Services Available",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                              );
                            }

                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: popularServices.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => ServiceWidget(
                                service: popularServices[index],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        if (FirebaseInit.auth.currentUser.isAnonymous) ...[
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => SignUp()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.88,
                              child: Image.asset(
                                "img/guest.png",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ]
                      ],
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
