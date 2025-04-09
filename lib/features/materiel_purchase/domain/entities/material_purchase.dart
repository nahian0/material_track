class MaterialPurchase {
  final int id;
  final String lineItemName;
  final String store;
  final String runnersName;
  final double amount;
  final String cardNumber;
  final String transactionDate;

  MaterialPurchase({
    required this.id,
    required this.lineItemName,
    required this.store,
    required this.runnersName,
    required this.amount,
    required this.cardNumber,
    required this.transactionDate,
  });
}
