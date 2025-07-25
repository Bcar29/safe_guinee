import 'package:get/get.dart';

class IsLoadingController extends GetxController {
  var isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  bool get isLoadingValue => isLoading.value;

  @override
  void onInit() {
    super.onInit();
    // You can initialize any data here if needed
  }
  
}