import 'package:flutter/material.dart';

class BookSearchListScreen extends StatefulWidget {
  const BookSearchListScreen({super.key});

  @override
  State<BookSearchListScreen> createState() => _BookSearchListScreenState();
}

class _BookSearchListScreenState extends State<BookSearchListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // floating: true,
            elevation: 0,
            title: Text('책 검색하기'),
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       context.pushNamed('/searchList');
            //     },
            //     // icon: const Icon(Icons.search),
            //   )
            // ],
          ),
          SliverToBoxAdapter(
            child: Text('data'),
          )
        ],
      ),
    );
  }
}
