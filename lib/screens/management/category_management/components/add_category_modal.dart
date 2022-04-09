import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/models/general/enums.dart';
import 'package:sliit_eats/models/general/success_message.dart';
import 'package:sliit_eats/screens/widgets/alert_dialog.dart';
import 'package:sliit_eats/screens/widgets/entry_field.dart';
import 'package:sliit_eats/services/category_service.dart';

class AddCategoryModal extends StatefulWidget {
  const AddCategoryModal({Key? key, required this.modalPurpose, required this.refresh, this.id = '', this.name = '' }) : super(key: key);
  final ModalPurpose modalPurpose;
  final Function refresh;
  final String id;
  final String name;

  @override
  _AddCategoryModalState createState() => _AddCategoryModalState();
}

class _AddCategoryModalState extends State<AddCategoryModal> {
  final TextEditingController _nameController = TextEditingController();
  dynamic progress;

  @override
  void initState() {
    super.initState();
    if(widget.name != ''){
      _nameController.text = widget.name;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: MediaQuery.of(context).orientation == Orientation.portrait ? 275 : MediaQuery.of(context).size.height,
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
                      EntryField(controller: _nameController, placeholder: 'Category Name', isPassword: false),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          String name = _nameController.text;
                          if (name != "") {
                            progress!.show();
                            dynamic res;
                            if (widget.modalPurpose == ModalPurpose.ADD) {
                              res = await CategoryService.addCategory(name);
                            } else {
                              res = await CategoryService.updateCategory(widget.id, name);
                            }
                            progress.dismiss();
                            if (res.runtimeType == SuccessMessage) {
                              await showCoolAlert(context, true, "Category ${widget.modalPurpose == ModalPurpose.ADD ? 'added' : 'updated'} successfully");
                              Navigator.of(context).pop();
                              widget.refresh();
                            } else {
                              await showCoolAlert(context, false, res.message);
                            }
                          } else {
                            await showCoolAlert(context, false, "Please enter a category name");
                          }
                        },
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
                            '${widget.modalPurpose == ModalPurpose.ADD ? 'Add' : 'Update'} Category',
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
