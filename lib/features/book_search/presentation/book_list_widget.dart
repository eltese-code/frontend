import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxaac_app/features/book_search/domain/book_pagination_model.dart';
import 'package:foxaac_app/features/book_search/provider/book_provider.dart';
import 'package:foxaac_app/shared/widget/my_separator.dart';

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

    final AsyncValue<BookPaginationModel> result =
        ref.watch(bookNotifierProvider(query));

    const imageWidth = 110.0;
    const imageHeight = 160.0;
    const outsidePadding = 15.0;
    const insidePadding = 5.0;
    const gap = 15.0;

    final textWidth = MediaQuery.of(context).size.width -
        imageWidth -
        gap -
        2 * (outsidePadding + insidePadding);

    return result.when(
      data: (data) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: data.items.length,
          itemBuilder: (context, index) {
            final bookItem = data.items[index];
            final title = bookItem.title.split('(')[0];

            return Column(
              children: [
                const MySeparator(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: outsidePadding),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(insidePadding),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Image.network(
                          bookItem.image,
                          height: imageHeight,
                          width: imageWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: gap),
                      SizedBox(
                        width: textWidth,
                        height: imageHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              bookItem.author,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              bookItem.description,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
      error: (error, st) => Center(child: Text(error.toString())),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
