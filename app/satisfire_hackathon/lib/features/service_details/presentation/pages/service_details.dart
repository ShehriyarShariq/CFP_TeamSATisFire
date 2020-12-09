import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:satisfire_hackathon/core/firebase/firebase.dart';
import 'package:satisfire_hackathon/core/ui/loader.dart';
import 'package:satisfire_hackathon/core/ui/no_glow_scroll_behavior.dart';
import 'package:satisfire_hackathon/features/chat_room/presentation/pages/chat_room_screen.dart';
import 'package:satisfire_hackathon/features/credentials/presentation/pages/sign_in.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/review.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/service.dart';
import 'package:satisfire_hackathon/features/service_details/domain/repositories/service_details_repository.dart';
import 'package:satisfire_hackathon/features/service_details/presentation/bloc/bloc/service_details_bloc.dart';
import 'package:satisfire_hackathon/features/service_details/presentation/widgets/service_images_pager_widget.dart';

import '../../../../injection_container.dart';

class ServiceDetails extends StatefulWidget {
  Service service;

  ServiceDetails({Key key, this.service}) : super(key: key);

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  ServiceDetailsBloc _bloc;

  List<Review> reviews = [];

  @override
  void initState() {
    super.initState();

    _bloc = sl<ServiceDetailsBloc>();
    _bloc.add(LoadReviewsEvent(
        func: () => sl<ServiceDetailsRepository>()
            .getServiceReviews(widget.service.id)));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );

    return BlocListener(
      cubit: _bloc,
      listener: (context, state) {
        if (state is ChatRoomEstablished) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ChatRoomScreen(
                        chatID: state.chatID,
                        members: {
                          'customer': FirebaseInit.auth.currentUser.uid,
                          'provider': widget.service.providerID,
                        },
                        providerName: widget.service.providerName,
                      )));
        }
      },
      child: Scaffold(
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 26,
                        ),
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
                                      "${widget.service.title}",
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
                                      "by ${widget.service.providerName}",
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
                                      images: widget.service.images,
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
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.service.description,
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
                                      "Service is available in ${widget.service.typeStr}",
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
                                      "Price Rs.${widget.service.price}",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        widget.service.rating.toString(),
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
                              BlocBuilder(
                                cubit: _bloc,
                                builder: (context, state) {
                                  if (state is Initial ||
                                      state is LoadingReviews) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Loader(),
                                      ),
                                    );
                                  } else if (state is LoadedReviews) {
                                    reviews.clear();
                                    reviews.addAll(state.reviews);
                                  }

                                  if (reviews.isEmpty) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Text(
                                          "No Reviews Yet",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Colors.black.withOpacity(0.4),
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: reviews.length,
                                    itemBuilder: (context, index) =>
                                        getReviewWidget(reviews[index]),
                                  );
                                },
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
                          !FirebaseInit.auth.currentUser.isAnonymous
                              ? 'Contact provider for booking >'
                              : "Login to chat...",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (!FirebaseInit.auth.currentUser.isAnonymous) {
                      _bloc.add(OpenChatRoomEvent(
                          func: () => sl<ServiceDetailsRepository>()
                              .makeChatRoom(widget.service.providerID)));
                    } else {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => SignIn()));
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getReviewWidget(Review review) {
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
            initialRating: review.rating.toDouble(),
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
            review.message,
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
