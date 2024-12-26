import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemController extends GetxController {
  final items = <Map<String, dynamic>>[].obs;
  final searchQuery = ''.obs;

  List<Map<String, dynamic>> get filteredItems {
    return items.where((item) {
      if (searchQuery.value.isEmpty) return true;
      final query = searchQuery.value.toLowerCase();
      return item['name'].toString().toLowerCase().contains(query) ||
          item['description'].toString().toLowerCase().contains(query);
    }).toList();
  }

  void addItem(String name, String description) {
    if (name.trim().isEmpty) return;
    
    items.add({
      'id': DateTime.now().toString(),
      'name': name.trim(),
      'description': description.trim(),
      'color': _getRandomColor(),
      'createdAt': DateTime.now(),
    });

    showNotification('Success', 'Item added successfully');
  }

  void updateItem(String id, String name, String description) {
    final index = items.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      items[index] = {
        ...items[index],
        'name': name.trim(),
        'description': description.trim(),
      };
      showNotification('Success', 'Item updated successfully');
    }
  }

  void deleteItem(String id) {
    items.removeWhere((item) => item['id'] == id);
    showNotification('Success', 'Item deleted successfully');
  }

  void showNotification(String title, String message, {bool isError = false}) {
    final isWeb = GetPlatform.isWeb;
    final screenWidth = Get.width;

    Get.snackbar(
      title,
      message,
     
      snackPosition: screenWidth < 550 ? SnackPosition.BOTTOM : SnackPosition.TOP,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      borderRadius: 8,
      margin: screenWidth < 550 
          ? const EdgeInsets.all(16) 
          : EdgeInsets.only( 
              top: 20,
              right: 20,
              left: Get.width - 320,
            ),
      snackStyle: SnackStyle.FLOATING,
      animationDuration: const Duration(milliseconds: 500),
      isDismissible: true,
      dismissDirection: screenWidth < 550 
          ? DismissDirection.vertical 
          : DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeInOutCubic,
      reverseAnimationCurve: Curves.easeInOutCubic,
      icon: Icon(
        isError ? Icons.error : Icons.check_circle,
        color: Colors.white,
      ),
      maxWidth: 300,
      borderColor: isError ? Colors.red[700] : Colors.green[700],
      borderWidth: 1,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  Color _getRandomColor() {
    final colors = [
      const Color(0xFF1E88E5), 
      const Color(0xFF43A047), 
      const Color(0xFFE53935), 
      const Color(0xFF8E24AA), 
      const Color(0xFFFFB300), 
      const Color(0xFF00897B), 
      const Color(0xFF5E35B1), 
      const Color(0xFFD81B60), 
      const Color(0xFF039BE5), 
      const Color(0xFF00ACC1), 
    ];
    return colors[DateTime.now().microsecond % colors.length];
  }

}