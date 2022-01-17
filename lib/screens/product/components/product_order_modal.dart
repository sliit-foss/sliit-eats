import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliit_eats/helpers/colors.dart';

class ProductOrderModal extends StatefulWidget {
  const ProductOrderModal({Key? key, required this.name, required this.price}) : super(key: key);
  final String name;
  final double price;

  @override
  _ProductOrderModalState createState() => _ProductOrderModalState();
}

class _ProductOrderModalState extends State<ProductOrderModal> {
  dynamic progress;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: MediaQuery.of(context).orientation == Orientation.portrait ? 240 : MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gray['dark']!,
              AppColors.gray['dark']!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: ProgressHUD(
          child: Builder(builder: (context) {
            progress = ProgressHUD.of(context);
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity--;
                              });
                            },
                            child: Icon(
                              FontAwesomeIcons.minusCircle,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            '$quantity Item${quantity > 1 ? 's' : ''}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: Icon(
                              FontAwesomeIcons.plusCircle,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: <BoxShadow>[BoxShadow(color: AppColors.primary.withAlpha(100), offset: Offset(2, 4), blurRadius: 8, spreadRadius: 2)],
                          ),
                          child: Text(
                            'Place Order',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
