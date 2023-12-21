import 'package:flutter/material.dart';
import 'package:foxaac_app/main.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  CustomSearchDelegate()
      : super(
          searchFieldLabel: '검색어를 입력해 주세요.',
          searchFieldStyle: const TextStyle(fontSize: 18),
        );
  final List<String> _data = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Fig",
    "Grapes",
    "Kiwi",
    "Lemon",
    "Mango",
    "Orange",
    "Papaya",
    "Raspberry",
    "Strawberry",
    "Tomato",
    "Watermelon",
  ];

  // 검색바 스타일
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = super.appBarTheme(context);

    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        // elevation: 1.0, // elevation 설정시 bg color가 바뀌는 문제
        backgroundColor: Colors.white,
        // shadowColor: popupBGColor,
      ),

      // textfield 테마 변경
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),

        // textfield 크기 조절
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        // textField color 변경
        filled: true,
        fillColor: $styles.colors.lightGrey,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> results = _data.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions =
        _data.where((element) => element.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
        );
      },
    );
  }
}
