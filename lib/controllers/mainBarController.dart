import 'package:get/get.dart';

class MainBarController extends GetxController {
  var _index = RxInt(1);
  int get currentIndex => _index.value;

  var userId = RxString('');

  void changeIndex(int index) {
    _index.value = index;
  }

  void openUserProfile(String userId) {
    this.userId.value = userId;
    _index.value = 1;
  }
}
