class MaterialPurchaseRequestModel {
  final List<MaterialPurchaseItem> materialPurchase;

  MaterialPurchaseRequestModel({required this.materialPurchase});

  Map<String, dynamic> toJson() {
    return {
      "material_purchase": materialPurchase.map((e) => e.toJson()).toList(),
    };
  }
}

class MaterialPurchaseItem {
  final String lineItemName;
  final String store;
  final String runnersName;
  final double amount;
  final dynamic cardNumber; // Change to dynamic to handle both String and Number
  final String transactionDate; // Format: MM-dd-yyyy

  MaterialPurchaseItem({
    required this.lineItemName,
    required this.store,
    required this.runnersName,
    required this.amount,
    required this.cardNumber,
    required this.transactionDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "line_item_name": lineItemName,
      "store": store,
      "runners_name": runnersName,
      "amount": amount,
      "card_number": cardNumber is String
          ? double.tryParse(cardNumber) // Convert string to double if it's not a number
          : cardNumber,
      "transaction_date": transactionDate,
    };
  }
}

