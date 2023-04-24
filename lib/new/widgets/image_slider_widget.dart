
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final List<String?>? imgList ;

  const ImageSlider({required this.imgList}) ;
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}
class _CarouselWithIndicatorState extends State<ImageSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
/*  final List<String> imgList = [
    "https://info.ama-digital.net/wp-content/uploads/2022/09/WhatsApp-Image-2022-09-26-at-1.20.01-PM.jpeg",
    "https://info.ama-digital.net/wp-content/uploads/2022/09/WhatsApp-Image-2022-09-26-at-1.20.01-PM-1.jpeg",
    "https://info.ama-digital.net/wp-content/uploads/2022/09/WhatsApp-Image-2022-09-26-at-1.20.00-PM.jpeg",
    "https://info.ama-digital.net/wp-content/uploads/2022/09/WhatsApp-Image-2022-09-26-at-1.20.01-PM-1-1.jpeg"
  ];*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    final List<Widget> imageSliders = widget.imgList!
        .map((item) => Container(
          height: 150,
          width: size.width ,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Image.network(item!, fit: BoxFit.fill)),
        ))
        .toList();

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              viewportFraction: 1,
              enlargeCenterPage: true,
              autoPlay: true,
              padEnds: false,
            clipBehavior: Clip.antiAlias,
              height: 170,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imgList!.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color: Colors.white60,
                        style: BorderStyle.solid,
                      ),
                      color: _current == entry.key ? Colors.white :Colors.transparent ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ) ;
  }
}