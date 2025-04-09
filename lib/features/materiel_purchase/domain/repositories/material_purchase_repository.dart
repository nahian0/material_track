import '../../data/models/material_purchase_request_model.dart';
import '../entities/material_purchase.dart';

abstract class MaterialPurchaseRepository {
  Future<List<MaterialPurchase>> getMaterialPurchases(int page);
  Future<void> addMaterialPurchase(MaterialPurchaseRequestModel request); // ⬅ New method
}
