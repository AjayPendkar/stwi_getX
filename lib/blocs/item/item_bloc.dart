import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'item_event.dart';
import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(const ItemState()) {
    on<AddItem>(_onAddItem);
    on<UpdateItem>(_onUpdateItem);
    on<DeleteItem>(_onDeleteItem);
    on<SearchItems>(_onSearchItems);
  }

  void _onAddItem(AddItem event, Emitter<ItemState> emit) {
    final newItem = {
      'id': DateTime.now().toString(),
      'name': event.name.trim(),
      'description': event.description.trim(),
      'color': _getRandomColor(),
      'createdAt': DateTime.now(),
    };

    final updatedItems = [...state.items, newItem];
    emit(state.copyWith(
      items: updatedItems,
      filteredItems: _filterItems(updatedItems, state.searchQuery),
      message: 'Item added successfully',
    ));
  }

  void _onUpdateItem(UpdateItem event, Emitter<ItemState> emit) {
    final updatedItems = state.items.map((item) {
      if (item['id'] == event.id) {
        return {
          ...item,
          'name': event.name.trim(),
          'description': event.description.trim(),
        };
      }
      return item;
    }).toList();

    emit(state.copyWith(
      items: updatedItems,
      filteredItems: _filterItems(updatedItems, state.searchQuery),
      message: 'Item updated successfully',
    ));
  }

  void _onDeleteItem(DeleteItem event, Emitter<ItemState> emit) {
    final updatedItems = state.items.where((item) => item['id'] != event.id).toList();
    emit(state.copyWith(
      items: updatedItems,
      filteredItems: _filterItems(updatedItems, state.searchQuery),
      message: 'Item deleted successfully',
    ));
  }

  void _onSearchItems(SearchItems event, Emitter<ItemState> emit) {
    emit(state.copyWith(
      searchQuery: event.query,
      filteredItems: _filterItems(state.items, event.query),
    ));
  }

  List<Map<String, dynamic>> _filterItems(List<Map<String, dynamic>> items, String query) {
    if (query.isEmpty) return items;
    
    final lowercaseQuery = query.toLowerCase();
    return items.where((item) {
      return item['name'].toString().toLowerCase().contains(lowercaseQuery) ||
          item['description'].toString().toLowerCase().contains(lowercaseQuery);
    }).toList();
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