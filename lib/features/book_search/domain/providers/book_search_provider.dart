import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxaac_app/features/book_search/data/data_sources/book_search_data_source.dart';
import 'package:foxaac_app/features/book_search/data/repositories/book_search_repository_impl.dart';
import 'package:foxaac_app/shared/dio/dio.dart';

final bookSearchDataSourceProvider = Provider.family<BookSearchDataSource, Dio>(
  (ref, dio) => BookSearchRemoteDataSource(dio),
);

final bookSearchRepositoryProvider = Provider((ref) {
  final dio = ref.read(dioProvider);

  final dataSource = ref.watch(bookSearchDataSourceProvider(dio));

  return BookSearchRepositoryImpl(dataSource: dataSource);
});
