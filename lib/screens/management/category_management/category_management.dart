import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/models/category.dart';
import 'package:sliit_eats/models/general/enums.dart';
import 'package:sliit_eats/models/general/sucess_message.dart';
import 'package:sliit_eats/screens/widgets/alert_dialog.dart';
import 'package:sliit_eats/screens/widgets/custom_appbar.dart';
import 'package:sliit_eats/screens/widgets/loading_screen.dart';
import 'package:sliit_eats/screens/widgets/rounded_button.dart';
import 'package:sliit_eats/services/category_service.dart';
import 'components/add_category_modal.dart';

class CategoryManagement extends StatefulWidget {
  const CategoryManagement({Key? key}) : super(key: key);

  @override
  _CategoryManagementState createState() => _CategoryManagementState();
}

class _CategoryManagementState extends State<CategoryManagement> {
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
    return Scaffold(
      appBar: customAppBar(title: 'Category Management', showBackArrow: true, onBackPressed: () => Navigator.of(context).pop()),
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
                future: CategoryService.getCategories(),
                builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: ListView.builder(
                          itemCount: snapshot.data!.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Spacer(),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 20, 10),
                                    child: RoundedButton(
                                      text: "Add New Category",
                                      buttonColor: AppColors.primary,
                                      horizontalPadding: 30,
                                      paddingTop: 10,
                                      borderRadius: 10,
                                      onPressed: () {
                                        return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AddCategoryModal(modalPurpose: ModalPurpose.ADD, refresh: _refresh);
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                                  width: double.infinity,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.cardColor,
                                        AppColors.cardColor,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.cardColor.withOpacity(0.2),
                                        blurRadius: 12,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 15),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index - 1].name,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () async {
                                          return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AddCategoryModal(
                                                modalPurpose: ModalPurpose.EDIT,
                                                refresh: _refresh,
                                                id: snapshot.data![index - 1].id,
                                                name: snapshot.data![index - 1].name,
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          color: Colors.greenAccent,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Center(
                                                child: Icon(
                                              FontAwesomeIcons.edit,
                                              color: Colors.white,
                                              size: 20,
                                            )),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          progress!.show();
                                          dynamic res = await CategoryService.deleteCategory(snapshot.data![index - 1].id);
                                          progress.dismiss();
                                          if (res.runtimeType == SuccessMessage) {
                                            await showCoolAlert(context, true, "Category deleted successfully");
                                            _refresh();
                                          } else {
                                            await showCoolAlert(context, false, res.message);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              topLeft: Radius.circular(0),
                                              bottomLeft: Radius.circular(0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Center(
                                                child: Icon(
                                              FontAwesomeIcons.minusCircle,
                                              color: Colors.white,
                                              size: 20,
                                            )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
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
            }),
          ),
        ),
      ),
    );
  }
}
