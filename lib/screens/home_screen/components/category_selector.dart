import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/models/category.dart';
import 'package:sliit_eats/models/general/callbacks.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({Key? key, required this.categories, required this.selectedCategory, required this.onCategoryTap}) : super(key: key);
  final List<Category>? categories;
  final String selectedCategory;
  final StringCallback onCategoryTap;

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.categories!
              .map((category) => GestureDetector(
                    onTap: () {
                      widget.onCategoryTap(category.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        width: 110,
                        decoration: BoxDecoration(
                          color: widget.selectedCategory == category.id ? AppColors.primary : Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Center(
                            child: Text(
                              category.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
