import '../../domain/entities/material_purchase.dart';

class MaterialPurchaseModel extends MaterialPurchase {
  MaterialPurchaseModel({
    required int id,
    required String lineItemName,
    required String store,
    required String runnersName,
    required double amount,
    required String cardNumber,
    required String transactionDate,
  }) : super(
    id: id,
    lineItemName: lineItemName,
    store: store,
    runnersName: runnersName,
    amount: amount,
    cardNumber: cardNumber,
    transactionDate: transactionDate,
  );

  factory MaterialPurchaseModel.fromJson(Map<String, dynamic> json) {
    return MaterialPurchaseModel(
      id: json['id'],
      lineItemName: json['line_item_name'],
      store: json['store'],
      runnersName: json['runners_name'],
      amount: json['amount'].toDouble(),
      cardNumber: json['card_number'],
      transactionDate: json['transaction_date'],
    );
  }
}
