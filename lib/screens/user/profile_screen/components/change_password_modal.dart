import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/models/general/success_message.dart';
import 'package:sliit_eats/screens/widgets/alert_dialog.dart';
import 'package:sliit_eats/screens/widgets/entry_field.dart';
import 'package:sliit_eats/services/auth_service.dart';

class ChangePasswordModal extends StatefulWidget {
  const ChangePasswordModal({Key? key}) : super(key: key);

  @override
  _ChangePasswordModalState createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<ChangePasswordModal> {
  final TextEditingController _passwordController = TextEditingController();
  dynamic progress;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: MediaQuery.of(context).orientation == Orientation.portrait ? 300 : MediaQuery.of(context).size.height,
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
                      EntryField(controller: _passwordController, placeholder: 'New Password', isPassword: true),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          String password = _passwordController.text;
                          if (password != "") {
                            progress!.show();
                            dynamic res = await AuthService.updatePassword(password);
                            progress.dismiss();
                            if (res.runtimeType == SuccessMessage) {
                              await showCoolAlert(context, true, "Password changed successfully");
                              Navigator.of(context).pop();
                            } else {
                              await showCoolAlert(context, false, res.message);
                            }
                          } else {
                            await showCoolAlert(context, false, "Please enter a password");
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
                            'Update Password',
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
