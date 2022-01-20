import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/models/canteen.dart';
import 'package:sliit_eats/models/category.dart';
import 'package:sliit_eats/models/product.dart';
import 'package:sliit_eats/screens/home_screen/components/category_selector.dart';
import 'package:sliit_eats/screens/home_screen/components/product_card.dart';
import 'package:sliit_eats/screens/widgets/loading_screen.dart';
import 'package:sliit_eats/services/canteen_service.dart';
import 'package:sliit_eats/services/category_service.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({Key? key}) : super(key: key);

  @override
  _BrowseTabState createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  String selectedCategory = 'all';
  String selectedCanteen = '';
  dynamic progress;
  bool firstLoad = true;
  Product demoProduct = Product(
    id: 'C1tmkRb2QwD3Pu8TQZD5',
    name: 'Coffee',
    canteen: 'sbdbB42',
    category: 'Beverages',
    unitPrice: 100,
    servings: 1,
    image:
        "https://platformmagazine.org/wp-content/uploads/2021/04/guy-basabose-FzdEbrA3Qj0-unsplash-scaled.jpg",
    unitsLeft: 10,
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  );

  Product demoProduct2 = Product(
    id: 'dweFERhiud64',
    name: 'Milk Tea',
    canteen: 'sbdbB42',
    category: 'Beverages',
    unitPrice: 120,
    servings: 1,
    image:
        "https://platformmagazine.org/wp-content/uploads/2021/04/guy-basabose-FzdEbrA3Qj0-unsplash-scaled.jpg",
    unitsLeft: 0,
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  );

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
                        image:
                            AssetImage("assets/images/browse/image$index.png"),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.18,
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
                    viewportFraction: 0.72,
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: CanteenService.getCanteens(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Canteen>> canteenSnapshot) {
                      if (canteenSnapshot.hasData) {
                        if (canteenSnapshot.data!.isNotEmpty) {
                          if (firstLoad) {
                            firstLoad = false;
                            selectedCanteen = canteenSnapshot.data![0].id;
                          }
                          return FutureBuilder(
                            future: CategoryService.getCategories(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Category>>
                                    categorySnapshot) {
                              if (categorySnapshot.hasData) {
                                if (categorySnapshot.data!.isNotEmpty) {
                                  if (categorySnapshot.data![0].id != 'all') {
                                    categorySnapshot.data!.insert(
                                        0, Category(id: 'all', name: 'All'));
                                  }
                                  return Column(
                                    children: [
                                      CategorySelector(
                                        categories: categorySnapshot.data,
                                        selectedCategory: selectedCategory,
                                        onCategoryTap: (String id) {
                                          setSelectedCategory(id);
                                        },
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Wrap(
                                            spacing:
                                                15.0, // gap between adjacent chips
                                            runSpacing:
                                                12.0, // gap between lines
                                            children: [
                                              ProductCard(
                                                thisProduct: demoProduct,
                                              ),
                                              ProductCard(
                                                thisProduct: demoProduct2,
                                              ),
                                              ProductCard(
                                                thisProduct: demoProduct,
                                              ),
                                              ProductCard(
                                                thisProduct: demoProduct,
                                              ),
                                              ProductCard(
                                                thisProduct: demoProduct,
                                              ),
                                              ProductCard(
                                                thisProduct: demoProduct,
                                              ),
                                              ProductCard(
                                                thisProduct: demoProduct,
                                              ),
                                              ProductCard(
                                                thisProduct: demoProduct,
                                              ),
                                              ProductCard(
                                                thisProduct: demoProduct,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      FormField<String>(
                                        builder:
                                            (FormFieldState<String> state) {
                                          return InputDecorator(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  Colors.white.withOpacity(0.1),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20, 10, 20, 10),
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 16.0),
                                              hintText: "Select Canteen",
                                              hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                            isEmpty: selectedCanteen == "",
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: selectedCanteen,
                                                isDense: true,
                                                onChanged: (canteen) {
                                                  setState(() {
                                                    selectedCanteen = canteen!;
                                                  });
                                                },
                                                dropdownColor:
                                                    AppColors.cardColor,
                                                items: canteenSnapshot.data!
                                                    .map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (Canteen canteen) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: canteen.id,
                                                    child: Text(
                                                      canteen.name,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          );
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
