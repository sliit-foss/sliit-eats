import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sliit_eats/helpers/colors.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({Key? key}) : super(key: key);

  @override
  _BrowseTabState createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.backgroundGradient['top']!,
            AppColors.backgroundGradient['bottom']!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          CarouselSlider.builder(
            carouselController: CarouselController(),
            itemCount: 7,
            itemBuilder: (BuildContext context, int index, int num) {
              return Image(
                image: AssetImage("assets/images/browse/image$index.png"),
                fit: BoxFit.cover,
              );
            },
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height* 0.2,
              aspectRatio: 2/1,
              reverse: false,
              autoPlay: true,
              initialPage: 0,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(seconds: 4),
              scrollDirection: Axis.horizontal,
              scrollPhysics: AlwaysScrollableScrollPhysics(),
              pauseAutoPlayOnManualNavigate: true,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {},
              viewportFraction: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
