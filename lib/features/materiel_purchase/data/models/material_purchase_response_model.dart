import 'material_purchase_list_model.dart';

class MaterialPurchaseResponseModel {
  final String statusCode;
  final String statusMessage;
  final MaterialPurchaseListModel materialPurchaseList;

  MaterialPurchaseResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.materialPurchaseList,
  });

  factory MaterialPurchaseResponseModel.fromJson(Map<String, dynamic> json) {
    return MaterialPurchaseResponseModel(
      statusCode: json['status_code'],
      statusMessage: json['status_message'],
      materialPurchaseList: MaterialPurchaseListModel.fromJson(json['material_purchase_list']),
    );
  }
}
