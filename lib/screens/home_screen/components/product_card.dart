import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/routes/app_routes.dart';
import 'package:sliit_eats/screens/widgets/custom_card.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.PRODUCT_DETAIL, arguments: {'product_id': 'safdafafd'});
      },
      child: CustomCard(
        color: AppColors.cardColor,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Hero(
                  tag: 'safdafafd',
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 100,
                    child: Image(
                      image: AssetImage("assets/images/browse/products/photo.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        " Coffee",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '\$ 2.00',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    width: 35,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
