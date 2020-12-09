import 'package:flutter/material.dart';

class ServiceImagesPagerWidget extends StatefulWidget {
  final List<String> images;

  const ServiceImagesPagerWidget({Key key, this.images}) : super(key: key);

  @override
  _ServiceImagesPagerWidgetState createState() =>
      _ServiceImagesPagerWidgetState();
}

class _ServiceImagesPagerWidgetState extends State<ServiceImagesPagerWidget> {
  PageController _pageController = PageController();
  num _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          children: widget.images
              .map(
                (image) => FittedBox(
                  fit: BoxFit.cover,
                  child: FadeInImage(
                      image: NetworkImage(image),
                      placeholder: AssetImage('img/service.png'),
                      fit: BoxFit.cover),
                ),
              )
              .toList(),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.width * 0.025,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
        )
      ],
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < widget.images.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: MediaQuery.of(context).size.width * 0.03,
      width: MediaQuery.of(context).size.width * 0.03,
      decoration: BoxDecoration(
          color: !isActive ? Colors.white.withOpacity(0.6) : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(100))),
    );
  }
}
