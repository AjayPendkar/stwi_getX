import 'package:equatable/equatable.dart';

class ItemState extends Equatable {
  final List<Map<String, dynamic>> items;
  final List<Map<String, dynamic>> filteredItems;
  final String searchQuery;
  final String? message;
  final bool isError;

  const ItemState({
    this.items = const [],
    this.filteredItems = const [],
    this.searchQuery = '',
    this.message,
    this.isError = false,
  });

  ItemState copyWith({
    List<Map<String, dynamic>>? items,
    List<Map<String, dynamic>>? filteredItems,
    String? searchQuery,
    String? message,
    bool? isError,
  }) {
    return ItemState(
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      searchQuery: searchQuery ?? this.searchQuery,
      message: message,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [items, filteredItems, searchQuery, message, isError];
} 