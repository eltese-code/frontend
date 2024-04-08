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
            elevation: 0,
            title: Text('책 검색하기'),
          ),
          SliverToBoxAdapter(
            child: Text('data'),
          )
        ],
      ),
    );
  }
}
