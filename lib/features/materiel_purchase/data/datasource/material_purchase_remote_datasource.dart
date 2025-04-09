import 'package:dio/dio.dart';
import '../models/material_purchase_model.dart';

class MaterialPurchaseRemoteDataSource {
  final Dio dio;

  MaterialPurchaseRemoteDataSource(this.dio);

  Future<List<MaterialPurchaseModel>> getMaterialPurchases(int page) async {
    final response = await dio.get(
      'https://devapi.propsoft.ai/api/auth/interview/material-purchase',
      queryParameters: {"page": page},
    );

    final List data = response.data['material_purchase_list']['data'];
    return data.map((e) => MaterialPurchaseModel.fromJson(e)).toList();
  }
}
