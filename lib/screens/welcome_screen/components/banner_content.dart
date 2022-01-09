import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sliit_eats/helpers/colors.dart';

class BannerContent extends StatefulWidget {
  const BannerContent({Key? key}) : super(key: key);

  @override
  _BannerContentState createState() => _BannerContentState();
}

class _BannerContentState extends State<BannerContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentPage = 0;

  List<String> slideImagePaths = [
    "assets/animations/welcome_screen/hot.json",
    "assets/animations/welcome_screen/crunchy.json",
    "assets/animations/welcome_screen/cold.json",
  ];

  AnimatedContainer buildSlideIndicator({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: 5),
      height: 8.0,
      width: currentPage == index ? 25 : 8,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: slideImagePaths.length);
    _tabController.addListener(onTabChange);
    if (_tabController.indexIsChanging) {
      onTabChange();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  buildSlide(String imagePath) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8, MediaQuery.of(context).orientation == Orientation.portrait ? 40 : 8, 8, MediaQuery.of(context).orientation == Orientation.portrait ? 40 : 20),
          child: Container(
            height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.35 : MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.55 : MediaQuery.of(context).size.width * 0.60,
            child: Lottie.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  onTabChange() {
    setState(() {
      currentPage = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.45 : MediaQuery.of(context).size.height * 0.65,
          child: TabBarView(
            controller: _tabController,
            children: [
              buildSlide(slideImagePaths[0]),
              buildSlide(slideImagePaths[1]),
              buildSlide(slideImagePaths[2]),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            slideImagePaths.length,
            (index) => buildSlideIndicator(index: index),
          ),
        ),
      ],
    );
  }
}
