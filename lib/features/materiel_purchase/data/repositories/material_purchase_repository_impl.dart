import '../../domain/entities/material_purchase.dart';
import '../../domain/repositories/material_purchase_repository.dart';
import '../datasource/material_purchase_remote_datasource.dart';

class MaterialPurchaseRepositoryImpl implements MaterialPurchaseRepository {
  final MaterialPurchaseRemoteDataSource remoteDataSource;

  MaterialPurchaseRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MaterialPurchase>> getMaterialPurchases(int page) {
    return remoteDataSource.getMaterialPurchases(page);
  }
}
