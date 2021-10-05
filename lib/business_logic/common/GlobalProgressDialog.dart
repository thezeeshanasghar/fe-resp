import 'package:flutter/cupertino.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class GlobalProgressDialog {
  SimpleFontelicoProgressDialog _simpleFontelicoProgressDialog;
  BuildContext _context;

  GlobalProgressDialog(BuildContext context) {
    this._context = context;
  }

  void showSimpleFontellicoProgressDialog(bool hasBarrierDimisable,
      String message, SimpleFontelicoProgressDialogType type) {
    _simpleFontelicoProgressDialog = SimpleFontelicoProgressDialog(
        context: _context, barrierDimisable: hasBarrierDimisable);
    _simpleFontelicoProgressDialog.show(
        message: message,
        type: type,
        width: MediaQuery.of(_context).size.width - 50);
  }

  void hideSimpleFontellicoProgressDialog() {
    _simpleFontelicoProgressDialog.hide();
  }
}
