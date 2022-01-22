import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/models/category.dart';
import 'package:sliit_eats/models/general/sucess_message.dart';
import 'package:sliit_eats/models/product.dart';
import 'package:sliit_eats/routes/app_routes.dart';
import 'package:sliit_eats/screens/home_screen/components/category_selector.dart';
import 'package:sliit_eats/screens/widgets/alert_dialog.dart';
import 'package:sliit_eats/screens/widgets/loading_screen.dart';
import 'package:sliit_eats/screens/widgets/rounded_button.dart';
import 'package:sliit_eats/services/category_service.dart';
import 'package:sliit_eats/services/product_service.dart';

class ProductDetailManagement extends StatefulWidget {
  const ProductDetailManagement({Key? key}) : super(key: key);

  @override
  _ProductDetailManagementState createState() =>
      _ProductDetailManagementState();
}

class _ProductDetailManagementState extends State<ProductDetailManagement> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  dynamic progress;
  final ImagePicker _imagePicker = ImagePicker();
  bool firstLoad = true;
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _descriptionController =
      new TextEditingController();
  final TextEditingController _unitPriceController =
      new TextEditingController();
  final TextEditingController _unitsLeftController =
      new TextEditingController();
  final TextEditingController _servingsController = new TextEditingController();

  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();
  }

  void setSelectedCategory(String id) {
    setState(() {
      _selectedCategory = id;
    });
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
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    Product thisProduct = snapshot.data;
                    if (firstLoad) {
                      firstLoad = false;
                      _selectedCategory = thisProduct.category;
                      _nameController.text = thisProduct.name;
                      _descriptionController.text = thisProduct.description;
                      _unitPriceController.text =
                          thisProduct.unitPrice.toString();
                      _unitsLeftController.text =
                          thisProduct.unitsLeft.toString();
                      _servingsController.text =
                          thisProduct.servings.toString();
                    }

                    return FutureBuilder(
                      future: CategoryService.getCategories(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Category>> categorySnapshot) {
                        if (categorySnapshot.hasData) {
                          if (categorySnapshot.data!.isNotEmpty) {
                            _selectedCategory = categorySnapshot.data![0].id;
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      XFile? image =
                                          await _imagePicker.pickImage(
                                              source: ImageSource.gallery);
                                      ProductService.uploadImage(
                                          File(image!.path), thisProduct.id);
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: Image.network(
                                                thisProduct.image,
                                              ).image)),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.black.withOpacity(0.8),
                                        height: 40,
                                        child: Text(
                                          "TAP to change image",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              letterSpacing: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  CategorySelector(
                                    categories: categorySnapshot.data,
                                    selectedCategory: _selectedCategory,
                                    onCategoryTap: (String id) {
                                      setSelectedCategory(id);
                                    },
                                  ),
                                  TextFormField(
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          letterSpacing: 2),
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              letterSpacing: 2),
                                          icon: Icon(Icons.emoji_food_beverage,
                                              color: Colors.white),
                                          labelText: 'Name')),
                                  TextFormField(
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          letterSpacing: 2),
                                      maxLines: 2,
                                      controller: _descriptionController,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              letterSpacing: 2),
                                          icon: Icon(Icons.edit,
                                              color: Colors.white),
                                          labelText: 'Description')),
                                  TextFormField(
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          letterSpacing: 2),
                                      keyboardType: TextInputType.number,
                                      controller: _unitPriceController,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              letterSpacing: 2),
                                          icon: Icon(Icons.attach_money,
                                              color: Colors.white),
                                          labelText: 'Unit Price (Rs.)')),
                                  TextFormField(
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          letterSpacing: 2),
                                      keyboardType: TextInputType.number,
                                      controller: _unitsLeftController,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              letterSpacing: 2),
                                          icon: Icon(
                                              Icons.dashboard_customize_rounded,
                                              color: Colors.white),
                                          labelText: 'Units left')),
                                  TextFormField(
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          letterSpacing: 2),
                                      keyboardType: TextInputType.number,
                                      controller: _servingsController,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              letterSpacing: 2),
                                          icon: Icon(Icons.group,
                                              color: Colors.white),
                                          labelText: 'Servings')),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 20, 10),
                                    child: RoundedButton(
                                      text: "Update Product",
                                      buttonColor: AppColors.primary,
                                      horizontalPadding: 30,
                                      paddingTop: 10,
                                      borderRadius: 10,
                                      onPressed: () async {
                                        Product
                                            updatedProduct =
                                            Product.updatedProduct(
                                                id: thisProduct.id,
                                                name: _nameController.text,
                                                canteen: thisProduct.canteen,
                                                category: _selectedCategory,
                                                unitPrice: int.parse(
                                                    _unitPriceController.text),
                                                servings: int.parse(
                                                    _servingsController.text),
                                                description:
                                                    _descriptionController.text,
                                                unitsLeft: int.parse(
                                                    _unitsLeftController.text));
                                        dynamic res =
                                            await ProductService.updateProduct(
                                                updatedProduct);
                                        if (res is SuccessMessage) {
                                          Navigator.popAndPushNamed(context,
                                              AppRoutes.PRODUCT_MANAGEMENT);
                                          await showCoolAlert(
                                              context, true, res.message);
                                        } else {
                                          await showCoolAlert(
                                              context, false, res.message,
                                              noAutoClose: true);
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 20, 10),
                                    child: RoundedButton(
                                      text: "DELETE Product",
                                      buttonColor: AppColors.fail,
                                      horizontalPadding: 30,
                                      paddingTop: 10,
                                      borderRadius: 10,
                                      onPressed: () async {
                                        dynamic res =
                                            ProductService.deleteProduct(
                                                thisProduct.id);

                                        if (res is SuccessMessage) {
                                          Navigator.popAndPushNamed(context,
                                              AppRoutes.PRODUCT_MANAGEMENT);
                                          await showCoolAlert(
                                              context, true, res.message);
                                        } else {
                                          await showCoolAlert(
                                              context, false, res.message,
                                              noAutoClose: true);
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
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
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
