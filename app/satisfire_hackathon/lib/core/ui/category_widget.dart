import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:satisfire_hackathon/core/util/utils.dart';
import 'package:satisfire_hackathon/features/all_categories/data/models/category.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;

  const CategoryWidget({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 10),
      child: AspectRatio(
        aspectRatio: 93 / 113,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                top: 2,
                bottom: 2,
                right: 2,
                left: 2,
                child: FadeInImage(
                    imageErrorBuilder: (context, exception, stackTrace) {
                      return Container(
                        child: Image.asset('img/service.png'),
                      );
                    },
                    image: NetworkImage(category.imageURL),
                    placeholder: AssetImage('img/service.png'),
                    fit: BoxFit.cover),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.33 * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Center(
                      child: AutoSizeText(
                        Utils.getFirstLetterOfWordsCapped(category.name),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
