import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/screens/widgets/loading_screen.dart';
import 'package:sliit_eats/screens/widgets/rounded_button.dart';
import 'package:sliit_eats/services/product_service.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  dynamic progress;

  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> _refresh() async {
    setState(() {});
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as dynamic;
    return Scaffold(
      body: Container(
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
              return FutureBuilder(
                future: ProductService.getProductById(args['product_id']),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          Hero(
                            tag: args['product_id'],
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.55,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: AssetImage("assets/images/browse/products/photo.jpg"), fit: BoxFit.cover)),
                              child: Column(
                                children: [
                                  Spacer(),
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                      child: Container(
                                        height: 110,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Coffee",
                                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 2),
                                              ),
                                              Text(
                                                "200 Orders",
                                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 2),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                "Only 99 Items Left!",
                                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 2),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Flexible(
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "\$",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      Text(
                                        " 2.00",
                                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 2),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              RoundedButton(text: 'Order Now', buttonColor: AppColors.primary, onPressed: () {})
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return LoadingIndicator();
                  }
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
