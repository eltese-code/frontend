import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxaac_app/features/book_search/domain/book_list_params.dart';
import 'package:foxaac_app/features/book_search/domain/book_pagination_model.dart';
import 'package:foxaac_app/features/book_search/presentation/book_list_shimmer_card.dart';
import 'package:foxaac_app/features/book_search/provider/book_provider.dart';
import 'package:foxaac_app/routes/router.dart';
import 'package:foxaac_app/shared/utils/logger.dart';
import 'package:foxaac_app/shared/widget/my_separator.dart';
import 'package:foxaac_app/shared/widget/my_shadow_container.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

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
  final ScrollController scrollController = ScrollController();

  void scrollListener() {
    final query = widget.query == '' ? 'ㄱ' : widget.query;

    if ((scrollController.position.maxScrollExtent) ==
        scrollController.offset) {
      logger.d('scroll');
      ref.read(bookNotifierProvider.notifier).fetchMore(query: query);
    }
  }

  @override
  void initState() {
    logger.d('책 검색 initState');
    final query = widget.query == '' ? 'ㄱ' : widget.query;
    ref
        .read(bookNotifierProvider.notifier)
        .get(params: BookListParams(query: query));

    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(bookNotifierProvider);

    const imageWidth = 110.0;
    const imageHeight = 160.0;
    const outsidePadding = 15.0;
    const insidePadding = 5.0;
    const gap = 15.0;

    final textWidth = MediaQuery.of(context).size.width -
        imageWidth -
        gap -
        2 * (outsidePadding + insidePadding) -
        5;

    if ([BookPaginationModelState.loading, BookPaginationModelState.initial]
        .contains(result.state)) {
      logger.d('로딩!');
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return BookListShimmerCard(
              imageHeight: imageHeight,
              imageWidth: imageWidth,
              textWidth: textWidth,
              gap: gap,
            );
          },
        ),
      );
    } else if (BookPaginationModelState.error == result.state) {
      return const SizedBox();
    } else {
      return Scrollbar(
        controller: scrollController,
        child: ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: result.items.length,
          itemBuilder: (context, index) {
            final bookItem = result.items[index];
            final title = bookItem.title;

            return GestureDetector(
              onTap: () {
                context.pushNamed(
                  ScreenPaths.bookDetail,
                  extra: bookItem,
                );
              },
              child: Column(
                children: [
                  const MySeparator(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: outsidePadding),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(insidePadding),
                      ),
                    ),
                    child: Row(
                      children: [
                        MyShadowContainer(
                          childWidget: Hero(
                            tag: bookItem.isbn,
                            child: Image.network(
                              bookItem.image,
                              height: imageHeight,
                              width: imageWidth,
                              fit: BoxFit.cover,
                            ).animate(delay: 2.seconds).shimmer(),
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
              ),
            );
          },
        ),
      );
    }
  }
}
