import 'package:flutter/cupertino.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class GlobalProgressDialog {
  SimpleFontelicoProgressDialog ?_simpleFontelicoProgressDialog;
  BuildContext?context;

  GlobalProgressDialog(context);

  // GlobalProgressDialog(context) {
  //   this._context = context;
  // }

  void showSimpleFontellicoProgressDialog(bool hasBarrierDimisable,
      String message, SimpleFontelicoProgressDialogType type,BuildContext context) {
    _simpleFontelicoProgressDialog = SimpleFontelicoProgressDialog(
     barrierDimisable: hasBarrierDimisable, context: context);
    _simpleFontelicoProgressDialog?.show(
        message: message,
        type: type,
        width: MediaQuery.of(context).size.width - 50);
  }

  void hideSimpleFontellicoProgressDialog() {
    _simpleFontelicoProgressDialog?.hide();
  }
}
