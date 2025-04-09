import 'package:get/get.dart';
import 'package:dio/dio.dart';  // Make sure Dio is imported
import '../../../../core/services/api_client.dart';
import '../../data/datasource/material_purchase_remote_datasource.dart';
import '../../data/repositories/material_purchase_repository_impl.dart';
import '../../domain/repositories/material_purchase_repository.dart'; // Import the repository interface
import '../../domain/usecases/add_materials.dart';
import '../../domain/usecases/get_materials.dart';
import '../controller/materiel_purchase_controller.dart';

class MaterialPurchaseBinding extends Bindings {
  @override
  void dependencies() {
    // Register Dio as a dependency
    // Register the ApiClient.dio as a dependency (using the globally configured Dio instance)
    Get.lazyPut(() => ApiClient.dio);

    // Register the MaterialPurchaseRemoteDataSource with Dio injected
    Get.lazyPut(() => MaterialPurchaseRemoteDataSource(Get.find()));

    // Register the MaterialPurchaseRepositoryImpl under the interface MaterialPurchaseRepository
    Get.lazyPut<MaterialPurchaseRepository>(
            () => MaterialPurchaseRepositoryImpl(Get.find())
    );

    // Register the GetMaterials use case
    Get.lazyPut(() => GetMaterialPurchases(Get.find()));
    Get.lazyPut(() => AddMaterialPurchase(Get.find()));

    // Register the MaterialPurchaseController with GetMaterials injected
    Get.lazyPut(() => MaterialPurchaseController(Get.find(),Get.find()));
  }
}
