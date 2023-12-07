import 'package:flutter/material.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: const Text('dd'),
    // );

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // floating: true,
            elevation: 0,
            title: const Text('나의 서재'),
            actions: [
              IconButton(
                onPressed: () {
                  //
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          const SliverToBoxAdapter(
            child: Text('data'),
          )
        ],
      ),
    );
  }
}
