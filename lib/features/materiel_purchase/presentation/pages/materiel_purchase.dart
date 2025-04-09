import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/materiel_purchase_controller.dart';
import '../../domain/entities/material_purchase.dart';

class MaterialPurchaseScreen extends StatelessWidget {
  const MaterialPurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MaterialPurchaseController>();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Material Purchase")),
        backgroundColor: Colors.white10,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.logout,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: const Icon(Icons.search), // Move the icon to the end
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade400), // Gray border color
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade400), // Gray border color when enabled
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue.shade400), // Blue border color when focused (optional)
                ),
              ),
              onChanged: (value) {
                // Optional: implement search logic
              },
            )

          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.materials.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.materials.isEmpty) {
          return const Center(child: Text("No materials available."));
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      // Header Row
                      Container(
                        color: const Color(0xFF0052FE),
                        child: Row(
                          children: const [
                            _HeaderCell('SL', width: 60),
                            _HeaderCell('User Role', width: 100),
                            _HeaderCell('Store', width: 120),
                            _HeaderCell("Runner's Name", width: 140),
                            _HeaderCell('Amount', width: 100),
                            _HeaderCell('Card No.', width: 120),
                            _HeaderCell('Date', width: 120),
                          ],
                        ),
                      ),
                      // Data Rows
                      ...List.generate(controller.materials.length, (index) {
                        final item = controller.materials[index];
                        final isEven = index % 2 == 0;
                        final rowColor =
                        isEven ? Colors.grey.shade200 : Colors.white;

                        return Container(
                          color: rowColor,
                          child: Row(
                            children: [
                              _DataCell('${index + 1}', width: 60),
                              const _DataCell('Admin', width: 100),
                              _DataCell(item.store, width: 120),
                              _DataCell(item.runnersName, width: 140),
                              _DataCell(
                                  '\$${item.amount.toStringAsFixed(2)}',
                                  width: 100),
                              _DataCell(item.cardNumber, width: 120),
                              _DataCell(item.transactionDate, width: 120),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),

            // Load More Button
            if (controller.hasMorePages.value &&
                !controller.isLoading.value)
              Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                  onPressed: controller.loadNextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0052FE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Load More"),
                ),
              ),
            if (controller.isLoading.value)
              const Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(),
              ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0052FE),
        child: const Icon(Icons.add),
        onPressed: () {
          // Navigate to add material page
        },
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final double width;

  const _HeaderCell(this.text, {required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.white),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  final double width;

  const _DataCell(this.text, {required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.grey),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
