import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:sliit_eats/helpers/colors.dart';

Future showCoolAlert(BuildContext context, bool success, String alertMessage, {bool noAutoClose = false}) async {
  await CoolAlert.show(
    context: context,
    text: alertMessage,
    title: "",
    autoCloseDuration: noAutoClose ? null : Duration(milliseconds: success ? 1900 : 1800),
    backgroundColor: Colors.transparent,
    lottieAsset: "assets/animations/modals/${success ? "success" : "error"}.json",
    iconHeight: success ? 140 : 120,
    loopAnimation: false,
    type: CoolAlertType.success,
    confirmBtnText: "Got It",
    showButtons: noAutoClose,
  );
}

Future showConfirmDialog(BuildContext context, Function onConfirm) async {
  await CoolAlert.show(
    context: context,
    text: "Are You Sure?",
    title: "",
    backgroundColor: Colors.transparent,
    lottieAsset: "assets/animations/modals/question.json",
    iconHeight: 150,
    loopAnimation: true,
    type: CoolAlertType.confirm,
    onConfirmBtnTap: () {
      onConfirm();
    },
    confirmBtnText: "Yes",
    confirmBtnColor: AppColors.primary,
    onCancelBtnTap: () => Navigator.of(context).pop(),
    showButtons: true,
  );
}
