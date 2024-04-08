import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxaac_app/features/book_search/domain/book_pagination_model.dart';
import 'package:foxaac_app/features/book_search/provider/book_provider.dart';

class BookListWidget extends ConsumerStatefulWidget {
  const BookListWidget({
    required this.query,
    super.key,
  });

  final String query;

  @override
  ConsumerState<BookListWidget> createState() => _BookListWidgetState();
}

class _BookListWidgetState extends ConsumerState<BookListWidget> {
  @override
  Widget build(BuildContext context) {
    final query = widget.query == '' ? 'ㄱ' : widget.query;

    final AsyncValue<BookPaginationModel> result = ref.watch(bookNotifierProvider(query));

    return result.when(
      data: (data) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: data.items.length,
          itemBuilder: (context, index) {
            final bookItem = data.items[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Image.network(
                      bookItem.image,
                      height: 160,
                      width: 110,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40 - 110 - 15,
                    height: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookItem.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          bookItem.author,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          bookItem.description,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      error: (error, st) => Center(child: Text(error.toString())),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
