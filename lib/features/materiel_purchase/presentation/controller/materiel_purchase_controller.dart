import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../../domain/entities/material_purchase.dart';
import '../../domain/usecases/get_materials.dart';

class MaterialPurchaseController extends GetxController {
  final GetMaterialPurchases getMaterials;

  MaterialPurchaseController(this.getMaterials);

  var materials = <MaterialPurchase>[].obs;
  var isLoading = false.obs;
  var page = 1;
  var hasMorePages = true.obs;  // Flag to track if there are more pages

  @override
  void onInit() {
    fetchMaterials();
    super.onInit();
  }

  void fetchMaterials() async {
    // If no more pages are available, do nothing
    if (!hasMorePages.value) return;

    isLoading.value = true;

    try {
      final result = await getMaterials(page);

      // If the result is empty, stop further pagination
      if (result.isEmpty) {
        hasMorePages.value = false;
        Get.snackbar("End", "No more materials available.");
      } else {
        materials.addAll(result); // Add the new data to the existing list
      }
    } catch (e) {
      // Handle any errors during the API request
      print("Error fetching materials: $e");
      Get.snackbar("Error", "Failed to load materials");
    } finally {
      isLoading.value = false;
    }
  }

  void loadNextPage() {
    // If there are more pages, increase the page count and load the next page
    if (hasMorePages.value) {
      page++;
      fetchMaterials();
    } else {
      Get.snackbar("End", "No more pages available");
    }
  }

  void logout() {
    GetStorage().erase(); // Clear session or token data
    Get.offAll(() => LoginPage()); // Navigate to the LoginPage
  }
}
