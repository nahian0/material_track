import 'material_purchase_model.dart';

class MaterialPurchaseListModel {
  final int currentPage;
  final List<MaterialPurchaseModel> data;
  final String? nextPageUrl;
  final int lastPage;

  MaterialPurchaseListModel({
    required this.currentPage,
    required this.data,
    required this.nextPageUrl,
    required this.lastPage,
  });

  factory MaterialPurchaseListModel.fromJson(Map<String, dynamic> json) {
    return MaterialPurchaseListModel(
      currentPage: json['current_page'],
      data: List<MaterialPurchaseModel>.from(
        json['data'].map((item) => MaterialPurchaseModel.fromJson(item)),
      ),
      nextPageUrl: json['next_page_url'],
      lastPage: json['last_page'],
    );
  }
}
