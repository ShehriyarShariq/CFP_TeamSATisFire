import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:satisfire_hackathon/core/ui/no_glow_scroll_behavior.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/service.dart';
import 'package:satisfire_hackathon/features/service_details/presentation/bloc/bloc/service_details_bloc.dart';
import 'package:satisfire_hackathon/features/service_details/presentation/widgets/service_images_pager_widget.dart';

class ServiceDetails extends StatefulWidget {
  Service service;

  ServiceDetails({Key key, this.service}) : super(key: key);

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  ServiceDetailsBloc _bloc;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.06),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 26,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Service Details",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: NoGlowScrollBehavior(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Cooking Class",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "by Shamma Bano",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: AspectRatio(
                                aspectRatio: 298 / 152,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ServiceImagesPagerWidget(
                                    images: [
                                      'https://i2.wp.com/www.eatthis.com/wp-content/uploads/2020/07/cooking-with-olive-oil.jpg?resize=640%2C360&ssl=1',
                                      'https://i2.wp.com/www.eatthis.com/wp-content/uploads/2020/07/cooking-with-olive-oil.jpg?resize=640%2C360&ssl=1'
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Learn how to cook a variety of cuisines. Specialty in Biryani.",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                      height: 1.3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Service is available Face to Face and Online",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                      color: Color(0xFFAF42AE),
                                      height: 1.3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Price Rs.1000",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                      height: 1.3,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rating and Reviews",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star,
                                        color: Color(0xFFFFC107), size: 18),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "4.5",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context, index) =>
                                  getReviewWidget(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 0.5,
                height: 1,
                color: Color(0xFFC28EC5),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              ),
              RaisedButton(
                elevation: 0.5,
                color: Color(0xFFC28EC5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Contact provider for booking >',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getReviewWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFAF42AE),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          RatingBar.builder(
            ignoreGestures: true,
            initialRating: 3,
            itemSize: 14,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Color(0xFFFFC107),
            ),
            onRatingUpdate: (rating) {},
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Excellent service. Shamma aunty taught me how to cook the best Biryani ever.",
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
