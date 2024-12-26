import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/item_controller.dart';
import '../widgets/item_list.dart';
import '../constants/app_colors.dart';

class HomeScreen extends GetView<ItemController> {
  const HomeScreen({super.key});

  void _showAddDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String name = '';
    String description = '';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Add New Item'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter item name',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      name = value ?? '';
                    },
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter item description',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 3,
                  onSaved: (value) {
                    description = value ?? '';
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  formKey.currentState?.save();
                  controller.addItem(name, description);
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Manager'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Item', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search items',
                  prefixIcon: const Icon(Icons.search, color: Colors.blue),
                  hintText: 'Search by name or description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: controller.setSearchQuery,
              ),
            ),
            Obx(() => ItemList(
              items: controller.filteredItems,
              onUpdate: controller.updateItem,
              onDelete: controller.deleteItem,
            )),
          ],
        ),
      ),
    );
  }
} 