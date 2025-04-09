import '../entities/material_purchase.dart';
import '../repositories/material_purchase_repository.dart';

class GetMaterialPurchases {
  final MaterialPurchaseRepository repository;

  GetMaterialPurchases(this.repository);

  Future<List<MaterialPurchase>> call(int page) {
    return repository.getMaterialPurchases(page);
  }
}
