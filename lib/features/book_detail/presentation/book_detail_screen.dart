import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxaac_app/features/book_add/presentation/book_add_sheet.dart';
import 'package:foxaac_app/features/book_search/domain/book_model.dart';
import 'package:foxaac_app/shared/widget/my_separator.dart';
import 'package:foxaac_app/shared/widget/my_shadow_container.dart';

class BookDetailScreen extends ConsumerWidget {
  const BookDetailScreen({
    super.key,
    required this.book,
  });

  final BookModel book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: renderFloatingActionButton(
        context,
        book: book,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            barrierColor: Colors.black.withOpacity(0.3),
            elevation: 0,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            context: context,
            builder: (context) {
              return BookAddSheet(book: book);
            },
          );
        },
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Hero(
                      tag: book.isbn,
                      child: MyShadowContainer(
                        childWidget: Image.network(
                          book.image,
                          height: 200,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      textAlign: TextAlign.center,
                      book.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: book.author,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: ' (지은이)',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const MySeparator(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text(
                        '책 소개',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(book.description),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

FloatingActionButton renderFloatingActionButton(
  BuildContext context, {
  required BookModel book,
  required void Function()? onPressed,
}) {
  return FloatingActionButton(
    elevation: 1,
    backgroundColor: const Color.fromARGB(255, 32, 32, 32),
    onPressed: onPressed,
    child: const Icon(
      Icons.add,
      color: Colors.white,
    ),
  );
}
