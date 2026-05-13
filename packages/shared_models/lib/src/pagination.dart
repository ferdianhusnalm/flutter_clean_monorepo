// packages/shared_models/lib/src/pagination.dart
import 'package:equatable/equatable.dart';

class PaginationMeta extends Equatable {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int perPage;

  const PaginationMeta({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.perPage,
  });

  bool get hasNextPage => currentPage < totalPages;
  bool get hasPreviousPage => currentPage > 1;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) => PaginationMeta(
    currentPage: json['current_page'] as int,
    totalPages: json['total_pages'] as int,
    totalItems: json['total_items'] as int,
    perPage: json['per_page'] as int,
  );

  @override
  List<Object?> get props => [currentPage, totalPages, totalItems, perPage];
}

class PaginatedResult<T> extends Equatable {
  final List<T> items;
  final PaginationMeta meta;

  const PaginatedResult({required this.items, required this.meta});

  @override
  List<Object?> get props => [items, meta];
}
