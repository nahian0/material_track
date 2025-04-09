import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../features/materiel_purchase/data/models/material_purchase_request_model.dart';

class DialogUtil {
  static void showMaterialPurchaseDialog(
      BuildContext context,
      void Function(MaterialPurchaseRequestModel) onSave,
      ) {
    final _formKey = GlobalKey<FormState>();
    final itemController = TextEditingController();
    final storeController = TextEditingController();
    final runnerNameController = TextEditingController();
    final amountController = TextEditingController();
    final cardNoController = TextEditingController();
    final dateController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          backgroundColor: Colors.white,
          child: SizedBox(
            width: 400,
            child: SingleChildScrollView(  // Make the content scrollable
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Blue title bar
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0052FE),
                    ),
                    child: const Center(
                      child: Text(
                        "Material Purchase",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildTextField("Item*", itemController),
                          const SizedBox(height: 10),
                          _buildTextField("Store*", storeController),
                          const SizedBox(height: 10),
                          _buildTextField("Runner's Name*", runnerNameController),
                          const SizedBox(height: 10),
                          _buildTextField("Amount*", amountController, isNumber: true),
                          const SizedBox(height: 10),
                          _buildCardNumberField(cardNoController),  // Custom card number field
                        // Replacing the original Date field with the custom one
                          const SizedBox(height: 10),
                          _buildDateField(dateController, context),
                          const SizedBox(height: 20),

                          // Save Button
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() && selectedDate != null) {
                                  final item = MaterialPurchaseItem(
                                    lineItemName: itemController.text,
                                    store: storeController.text,
                                    runnersName: runnerNameController.text,
                                    amount: double.tryParse(amountController.text) ?? 0,
                                    cardNumber: cardNoController.text,
                                    transactionDate: DateFormat('MM-dd-yyyy').format(selectedDate!),
                                  );

                                  final request = MaterialPurchaseRequestModel(materialPurchase: [item]);
                                  onSave(request);
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0052FE),
                                foregroundColor: Colors.white,
                                textStyle: TextStyle(color: Colors.white),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Save"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildDateField(TextEditingController dateController, BuildContext context) {
    DateTime? selectedDate;

    return Row(
      children: [
        // Label aligned to the left
        Container(
          width: 100,  // Fixed width for the label
          child: const Text(
            "Date*",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,  // No bold
            ),
          ),
        ),
        const SizedBox(width: 16),  // Gap between the label and text field
        // TextFormField with reduced length
        SizedBox(
          width: 200,  // Reduced width of the input box
          child: TextFormField(
            controller: dateController,
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (selectedDate != null) {
                dateController.text = DateFormat('MM-dd-yyyy').format(selectedDate!);
              }
            },
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
        ),
      ],
    );
  }


  static Widget _buildTextField(
      String label,
      TextEditingController controller, {
        bool isNumber = false,
      }) {
    return Row(
      children: [
        // Label aligned to the left
        Container(
          width: 100,  // Fixed width for the label
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,  // No bold
            ),
          ),
        ),
        const SizedBox(width: 16),  // Gap between the label and text field
        // TextFormField with reduced length
        SizedBox(
          width: 200,  // Reduced width of the input box
          child: TextFormField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            validator: (value) => value == null || value.isEmpty ? 'Required' : null,
          ),
        ),
      ],
    );
  }



  // Custom method for the card number field
  static Widget _buildCardNumberField(TextEditingController controller) {
    return Row(
      children: [
        // Label aligned to the left
        Container(
          width: 100,  // Fixed width for the label
          child: const Text(
            "Card No*",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,  // No bold
            ),
          ),
        ),
        const SizedBox(width: 16),  // Gap between the label and text field
        // TextFormField with reduced length
        SizedBox(
          width: 200,  // Reduced width of the input box
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              } else if (value.length != 5) {
                return 'Card number must be exactly 5 digits';
              } else if (!RegExp(r'^\d{5}$').hasMatch(value)) {
                return 'Card number must contain only digits';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

}

