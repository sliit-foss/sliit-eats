import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/main.dart';
import 'package:sliit_eats/models/category.dart';
import 'package:sliit_eats/models/general/success_message.dart';
import 'package:sliit_eats/models/product.dart';
import 'package:sliit_eats/screens/home_screen/components/category_selector.dart';
import 'package:sliit_eats/screens/widgets/alert_dialog.dart';
import 'package:sliit_eats/screens/widgets/entry_text_form_field.dart';
import 'package:sliit_eats/screens/widgets/loading_screen.dart';
import 'package:sliit_eats/screens/widgets/rounded_button.dart';
import 'package:sliit_eats/services/category_service.dart';
import 'package:sliit_eats/services/product_service.dart';

class ProductAddUpdate extends StatefulWidget {
  const ProductAddUpdate({Key? key}) : super(key: key);

  @override
  _ProductAddUpdateState createState() => _ProductAddUpdateState();
}

class _ProductAddUpdateState extends State<ProductAddUpdate> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  dynamic progress;
  final ImagePicker _imagePicker = ImagePicker();
  late Future<XFile?> pickedFile = Future.value(null);
  dynamic imageFile;
  bool firstLoad = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _descriptionController = new TextEditingController();
  final TextEditingController _unitPriceController = new TextEditingController();
  final TextEditingController _unitsLeftController = new TextEditingController();
  final TextEditingController _servingsController = new TextEditingController();

  Product? thisProduct;
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

  Future<dynamic> getProductFuture(String? productId) async {
    if (productId != null) return ProductService.getProductById(productId);
    return true;
  }

  Widget imageSelector(String? path, bool fileImage) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: MediaQuery.of(context).size.height * 0.48,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: path != null
                    ? fileImage
                        ? Image.file(File(path), fit: BoxFit.cover)
                        : Image.network(path, fit: BoxFit.cover)
                    : Lottie.asset("assets/animations/products/image_upload.json", fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.6),
              height: 40,
              child: Text(
                "TAP to add image",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white, letterSpacing: 2),
              ),
            ),
          ),
        ],
      ),
    );
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
                future: getProductFuture(args['product_id']),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    if (firstLoad && args['product_id'] != null) {
                      thisProduct = snapshot.data;
                      firstLoad = false;
                      _selectedCategory = thisProduct!.category;
                      _nameController.text = thisProduct!.name;
                      _descriptionController.text = thisProduct!.description;
                      _unitPriceController.text = thisProduct!.unitPrice.toString();
                      _unitsLeftController.text = thisProduct!.unitsLeft.toString();
                      _servingsController.text = thisProduct!.servings.toString();
                    }
                    return FutureBuilder(
                      future: CategoryService.getCategories(),
                      builder: (BuildContext context, AsyncSnapshot<List<Category>> categorySnapshot) {
                        if (categorySnapshot.hasData) {
                          if (categorySnapshot.data!.isNotEmpty) {
                            if (firstLoad) {
                              firstLoad = false;
                              _selectedCategory = categorySnapshot.data![0].id;
                            }

                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          pickedFile = _imagePicker.pickImage(source: ImageSource.gallery).whenComplete(() => {setState(() {})});
                                        },
                                        child: FutureBuilder<XFile?>(
                                          future: pickedFile,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData || args['product_id'] != null) {
                                              String imagePath = args['product_id'] != null && !snapshot.hasData ? thisProduct!.image : snapshot.data!.path;
                                              imageFile = File(imagePath);
                                              return imageSelector(imagePath, snapshot.hasData);
                                            } else {
                                              return imageSelector(null, false);
                                            }
                                          },
                                        ),
                                      ),
                                      CategorySelector(
                                        categories: categorySnapshot.data,
                                        selectedCategory: _selectedCategory,
                                        onCategoryTap: (String id) {
                                          setSelectedCategory(id);
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                        child: Column(
                                          children: [
                                            EntryTextFormField(controller: _nameController, prefixIcon: Icon(Icons.emoji_food_beverage, color: Colors.white), labelText: 'Name'),
                                            EntryTextFormField(controller: _descriptionController, prefixIcon: Icon(Icons.edit, color: Colors.white), labelText: 'Description'),
                                            EntryTextFormField(
                                              controller: _unitPriceController,
                                              prefixIcon: Icon(Icons.attach_money, color: Colors.white),
                                              labelText: 'Unit Price (Rs.)',
                                              textInputType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                            ),
                                            EntryTextFormField(
                                              controller: _unitsLeftController,
                                              prefixIcon: Icon(Icons.dashboard_customize_rounded, color: Colors.white),
                                              labelText: 'Units left',
                                              textInputType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                            ),
                                            EntryTextFormField(
                                              controller: _servingsController,
                                              prefixIcon: Icon(Icons.group, color: Colors.white),
                                              labelText: 'Servings',
                                              textInputType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                              width: MediaQuery.of(context).size.width,
                                              child: RoundedButton(
                                                text: args['product_id'] != null ? "Update Product" : "Add Product",
                                                buttonColor: AppColors.primary,
                                                paddingTop: 10,
                                                borderRadius: 5,
                                                onPressed: () async {
                                                  if (_formKey.currentState!.validate()) {
                                                    if (imageFile == null && args['product_id'] == null) {
                                                      await showCoolAlert(context, false, "Please select an image", noAutoClose: true);
                                                    } else {
                                                      progress.show();
                                                      Product product;
                                                      dynamic res;
                                                      if (args['product_id'] != null) {
                                                        product = Product.updatedProduct(
                                                            id: thisProduct!.id,
                                                            name: _nameController.text,
                                                            canteen: thisProduct!.canteen,
                                                            category: _selectedCategory,
                                                            unitPrice: int.parse(_unitPriceController.text),
                                                            servings: int.parse(_servingsController.text),
                                                            description: _descriptionController.text,
                                                            unitsLeft: int.parse(_unitsLeftController.text));
                                                        res = await ProductService.updateProduct(product);
                                                        if (imageFile != null) ProductService.uploadImage(imageFile, thisProduct!.id);
                                                      } else {
                                                        product = Product.newProduct(
                                                            name: _nameController.text,
                                                            canteen: currentLoggedInUser.canteenId!,
                                                            category: _selectedCategory,
                                                            unitPrice: int.parse(_unitPriceController.text),
                                                            servings: int.parse(_servingsController.text),
                                                            description: _descriptionController.text,
                                                            unitsLeft: int.parse(_unitsLeftController.text));
                                                        res = await ProductService.addNewProduct(currentLoggedInUser.canteenId!, product, imageFile);
                                                      }
                                                      progress.dismiss();
                                                      if (res is SuccessMessage) {
                                                        await showCoolAlert(context, true, res.message);
                                                        Navigator.of(context).pop();
                                                        args['refresh']();
                                                      } else {
                                                        await showCoolAlert(context, false, res.message, noAutoClose: true);
                                                      }
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                            args['product_id'] != null
                                                ? Container(
                                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                                    width: MediaQuery.of(context).size.width,
                                                    child: RoundedButton(
                                                      text: "DELETE Product",
                                                      buttonColor: AppColors.fail,
                                                      paddingTop: 10,
                                                      borderRadius: 5,
                                                      onPressed: () {
                                                        showConfirmDialog(
                                                          context,
                                                          () async {
                                                            progress.show();
                                                            dynamic res = await ProductService.deleteProduct(thisProduct!.id);
                                                            progress.dismiss();
                                                            if (res is SuccessMessage) {
                                                              await showCoolAlert(context, true, res.message);
                                                              Navigator.of(context).pop();
                                                              Navigator.of(context).pop();
                                                              args['refresh']();
                                                            } else {
                                                              await showCoolAlert(context, false, res.message, noAutoClose: true);
                                                            }
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
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
