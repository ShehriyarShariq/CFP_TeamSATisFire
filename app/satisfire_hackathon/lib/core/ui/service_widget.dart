import 'package:flutter/material.dart';
import 'package:satisfire_hackathon/core/util/utils.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/service.dart';
import 'package:satisfire_hackathon/features/service_details/presentation/pages/service_details.dart';

class ServiceWidget extends StatelessWidget {
  final Service service;

  const ServiceWidget({Key key, this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ServiceDetails(
                        service: service,
                      )));
        },
        child: Center(
          child: AspectRatio(
            aspectRatio: 300 / 160,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: service.images.isNotEmpty
                        ? FadeInImage(
                            imageErrorBuilder:
                                (context, exception, stackTrace) {
                              return Container(
                                child: Image.asset('img/service.png'),
                              );
                            },
                            image: NetworkImage(service.images[0]),
                            placeholder: AssetImage('img/service.png'),
                            fit: BoxFit.cover)
                        : Image.asset("img/service.png", fit: BoxFit.cover),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      height: (MediaQuery.of(context).size.width * 0.8) *
                          (160 / 300) *
                          0.35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  service.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  service.providerName,
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Color(0xFFFFC107),
                                            size: 14,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "${service.rating} - ${Utils.getFirstLetterOfWordsCapped(service.category.name)}",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
