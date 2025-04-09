import '../repositories/material_purchase_repository.dart';
import '../../data/models/material_purchase_request_model.dart';

class AddMaterialPurchase {
  final MaterialPurchaseRepository repository;

  AddMaterialPurchase(this.repository);

  Future<void> call(MaterialPurchaseRequestModel request) {
    return repository.addMaterialPurchase(request);
  }
}
