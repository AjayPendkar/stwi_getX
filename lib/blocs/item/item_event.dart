import 'package:equatable/equatable.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class AddItem extends ItemEvent {
  final String name;
  final String description;

  const AddItem(this.name, this.description);

  @override
  List<Object> get props => [name, description];
}

class UpdateItem extends ItemEvent {
  final String id;
  final String name;
  final String description;

  const UpdateItem(this.id, this.name, this.description);

  @override
  List<Object> get props => [id, name, description];
}

class DeleteItem extends ItemEvent {
  final String id;

  const DeleteItem(this.id);

  @override
  List<Object> get props => [id];
}

class SearchItems extends ItemEvent {
  final String query;

  const SearchItems(this.query);

  @override
  List<Object> get props => [query];
} 