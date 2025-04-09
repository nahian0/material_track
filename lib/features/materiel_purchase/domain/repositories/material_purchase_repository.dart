import '../entities/material_purchase.dart';

abstract class MaterialPurchaseRepository {
  Future<List<MaterialPurchase>> getMaterialPurchases(int page);
}
