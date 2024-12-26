import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_manager/widgets/notification_service.dart';
import '../blocs/item/bloc.dart';
import '../widgets/item_list.dart';
import '../constants/app_colors.dart';
import '../widgets/add_item_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) => const AddItemForm(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemBloc, ItemState>(
      listenWhen: (previous, current) => previous.message != current.message,
      listener: (context, state) {
        if (state.message != null) {
          NotificationService.showSnackBar(
            context,
            message: state.message!,
            isError: state.isError,
          );
        }
      },
      child: Scaffold(
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
                  onChanged: (query) => context.read<ItemBloc>().add(SearchItems(query)),
                ),
              ),
              BlocBuilder<ItemBloc, ItemState>(
                builder: (context, state) {
                  return ItemList(
                    items: state.filteredItems,
                    onUpdate: (id, name, description) => 
                        context.read<ItemBloc>().add(UpdateItem(id, name, description)),
                    onDelete: (id) => 
                        context.read<ItemBloc>().add(DeleteItem(id)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
} 