import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/models/product.dart';
import 'package:sliit_eats/routes/app_routes.dart';
import 'package:sliit_eats/screens/widgets/custom_card.dart';
import 'package:sliit_eats/screens/widgets/loading_screen.dart';
import 'package:sliit_eats/services/category_service.dart';

class ManageProductCard extends StatefulWidget {
  const ManageProductCard({Key? key, required this.thisProduct, required this.refresh}) : super(key: key);
  final Product thisProduct;
  final Function refresh;

  @override
  _ManageProductCardState createState() => _ManageProductCardState();
}

class _ManageProductCardState extends State<ManageProductCard> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
        color: AppColors.cardColor,
        child: FutureBuilder(
            future: CategoryService.getCategories(filters: [
              {'name': 'id', 'value': widget.thisProduct.category}
            ]),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                String categoryName = snapshot.data![0].name;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Hero(
                        tag: widget.thisProduct.name,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.25,
                          child: Image.network(
                            widget.thisProduct.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.thisProduct.name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Rs. ${widget.thisProduct.unitPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        widget.thisProduct.unitsLeft == 0
                            ? Text(
                                'OUT of stock',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.fail,
                                ),
                              )
                            : Text(
                                '${widget.thisProduct.unitsLeft} in stock',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.success,
                                ),
                              ),
                        Text(
                          categoryName.toUpperCase(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.PRODUCT_ADD_UPDATE, arguments: {'product_id': widget.thisProduct.id, 'refresh': widget.refresh});
                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primary),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                              child: Icon(
                            FontAwesomeIcons.edit,
                            color: Colors.white,
                            size: 20,
                          )),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return LoadingIndicator();
              }
            }));
  }
}
