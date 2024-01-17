import 'package:dalmia/app/modules/accounts/controllers/accountsController.dart';
import 'package:get/get.dart';

class Accounts extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountsController>(
      () => AccountsController(),
    );
  }
}
