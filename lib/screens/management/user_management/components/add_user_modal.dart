import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/models/general/sucess_message.dart';
import 'package:sliit_eats/screens/widgets/alert_dialog.dart';
import 'package:sliit_eats/screens/widgets/entry_field.dart';
import 'package:sliit_eats/services/auth_service.dart';

class AddUserModal extends StatefulWidget {
  const AddUserModal({Key? key, required this.refresh}) : super(key: key);
  final Function refresh;

  @override
  _AddUserModalState createState() => _AddUserModalState();
}

class _AddUserModalState extends State<AddUserModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  dynamic progress;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: MediaQuery.of(context).orientation == Orientation.portrait ? 400 : MediaQuery.of(context).size.height,
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
                      EntryField(controller: _nameController, placeholder: 'Username', isPassword: false),
                      EntryField(controller: _emailController, placeholder: 'Email', isPassword: false),
                      EntryField(controller: _passwordController, placeholder: 'Password', isPassword: true),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          String name = _nameController.text;
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          if (name != "") {
                            if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
                              if (password != "") {
                                progress!.show();
                                dynamic res = await AuthService.signUp(email, password, name, true, '');
                                progress.dismiss();
                                if (res.runtimeType == SuccessMessage) {
                                  await showCoolAlert(context, true, "User added successfully");
                                  Navigator.of(context).pop();
                                  widget.refresh();
                                } else {
                                  await showCoolAlert(context, false, res.message);
                                }
                              } else {
                                await showCoolAlert(context, false, "Please enter a password");
                              }
                            } else {
                              await showCoolAlert(context, false, "Please enter a valid email");
                            }
                          } else {
                            await showCoolAlert(context, false, "Please enter a username");
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
                            'Add User',
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
