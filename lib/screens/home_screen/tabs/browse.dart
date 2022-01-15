import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/models/canteen.dart';
import 'package:sliit_eats/models/category.dart';
import 'package:sliit_eats/screens/home_screen/components/category_selector.dart';
import 'package:sliit_eats/screens/widgets/loading_screen.dart';
import 'package:sliit_eats/services/canteen_service.dart';
import 'package:sliit_eats/services/category_service.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({Key? key}) : super(key: key);

  @override
  _BrowseTabState createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  String selectedCategory = 'all';
  dynamic progress;

  void setSelectedCategory(String id) {
    setState(() {
      selectedCategory = id;
    });
  }

  Future<dynamic> _refresh() async {
    setState(() {});
    return false;
  }

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
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ProgressHUD(
          child: Builder(builder: (context) {
            progress = ProgressHUD.of(context);
            return Column(
              children: [
                CarouselSlider.builder(
                  carouselController: CarouselController(),
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index, int num) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(
                        image: AssetImage("assets/images/browse/image$index.png"),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.2,
                    aspectRatio: 2 / 1,
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
                Expanded(
                  child: FutureBuilder(
                    future: CanteenService.getCanteens(),
                    builder: (BuildContext context, AsyncSnapshot<List<Canteen>> snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data);
                        if (snapshot.data!.isNotEmpty) {
                          return FutureBuilder(
                            future: CategoryService.getCategories(),
                            builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.isNotEmpty) {
                                  if (snapshot.data![0].id != 'all') {
                                    snapshot.data!.insert(0, Category(id: 'all', name: 'All', canteenId: ''));
                                  }
                                  return Column(
                                    children: [
                                      CategorySelector(
                                        categories: snapshot.data,
                                        selectedCategory: selectedCategory,
                                        onCategoryTap: (String id) {
                                          setSelectedCategory(id);
                                        },
                                      ),
                                    ],
                                  );
                                } else {
                                  return LoadingIndicator();
                                }
                              } else {
                                return LoadingIndicator();
                              }
                            },
                          );
                        } else {
                          return LoadingIndicator();
                        }
                      } else {
                        return LoadingIndicator();
                      }
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
