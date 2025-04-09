import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../../domain/entities/material_purchase.dart';
import '../../domain/usecases/get_materials.dart';

class MaterialPurchaseController extends GetxController {
  final GetMaterialPurchases getMaterials;
  late ScrollController scrollController;

  MaterialPurchaseController(this.getMaterials);

  var materials = <MaterialPurchase>[].obs;
  var filteredMaterials = <MaterialPurchase>[].obs;  // For storing filtered list
  var isLoading = false.obs;
  var page = 1;
  var hasMorePages = true.obs;
  var isLoadingNextPage = false.obs;
  var searchQuery = ''.obs; // Store the search query

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    fetchMaterials();
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      loadNextPage();
    }
  }

  void fetchMaterials() async {
    if (!hasMorePages.value) return;

    isLoading.value = true;
    try {
      final result = await getMaterials(page);

      if (result.isEmpty) {
        hasMorePages.value = false;
        Get.snackbar("End", "No more materials available.");
      } else {
        materials.addAll(result);
        filteredMaterials.addAll(result); // Initially, show all materials
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load materials");
    } finally {
      isLoading.value = false;
    }
  }

  void loadNextPage() {
    if (hasMorePages.value) {
      page++;
      fetchMaterials();
    } else {
      //Get.snackbar("End", "No more pages available");
    }
  }

  void searchMaterials(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredMaterials.value = materials; // If query is empty, show all materials
    } else {
      filteredMaterials.value = materials
          .where((material) =>
      material.lineItemName.toLowerCase().contains(query.toLowerCase()) ||
          material.store.toLowerCase().contains(query.toLowerCase()) ||
          material.runnersName.toLowerCase().contains(query.toLowerCase()) ||
          material.cardNumber.toLowerCase().contains(query.toLowerCase()) ||
          material.transactionDate.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void logout() {
    GetStorage().erase();
    Get.offAll(() => LoginPage());
  }
}
