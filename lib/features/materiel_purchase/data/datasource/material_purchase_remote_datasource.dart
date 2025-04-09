import 'package:dio/dio.dart';
import '../models/material_purchase_model.dart';
import '../models/material_purchase_request_model.dart';

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

  Future<void> addMaterialPurchase(MaterialPurchaseRequestModel requestModel) async {
    try {
      final response = await dio.post(
        'https://devapi.propsoft.ai/api/auth/interview/material-purchase',
        data: requestModel.toJson(),
      );
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.data}");
    } catch (e) {
      if (e is DioException) {
        print("Dio error:");
        print("Status Code: ${e.response?.statusCode}");
        print("Response: ${e.response?.data}");
        print("Message: ${e.message}");
      } else {
        print("Unexpected error: $e");
      }
      rethrow;
    }
  }

}
