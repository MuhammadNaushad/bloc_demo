import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class CommonWidgets {
  ///Loading Progress Indicator
  static final SimpleFontelicoProgressDialog _dialog =
      SimpleFontelicoProgressDialog(context: Get.overlayContext!);
  static void showDialog() async {
    _dialog.show(
        message: 'Loading...', type: SimpleFontelicoProgressDialogType.normal);
  }

  static void hideDialog() async {
    _dialog.hide();
  }
}
