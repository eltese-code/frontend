import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foxaac_app/assets.dart';
import 'package:go_router/go_router.dart';

class LadderScreen extends ConsumerStatefulWidget {
  const LadderScreen({super.key});

  @override
  ConsumerState<LadderScreen> createState() => _LadderScreenState();
}

class _LadderScreenState extends ConsumerState<LadderScreen> {
  @override
  Widget build(BuildContext context) {
    // String query = '';
    // ref.read(bookListProvider.notifier).paginate(query: query);

    final size = MediaQuery.of(context).size;
    final List bookList = [
      '지구 끝의 온실',
      '물고기는 존재하지 않는다',
      '이선 프롬',
      '폭풍의 언덕',
      '내가 되는 꿈',
      '쿼런틴',
      '좁은 문',
      '마음의 심연',
      '전원 교향악',
      '끌림',
      '지구 끝의 온실',
      '물고기는 존재하지 않는다',
      '이선 프롬',
      '폭풍의 언덕',
      '내가 되는 꿈',
      '쿼런틴',
      '좁은 문',
      '마음의 심연',
      '전원 교향악',
      '끌림',
      '이선 프롬',
      '폭풍의 언덕',
      '내가 되는 꿈',
      '쿼런틴',
      '좁은 문',
      '마음의 심연',
      '전원 교향악',
      '끌림',
    ];
    final keys = GlobalKey<AnimatedListState>();

    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          context.pushNamed('bookList');
        },
        child: SvgPicture.asset(
          'assets/images/ladder/book.svg',
          color: const Color(0xFF1E1B18),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 34, 38, 78).withOpacity(.5),
              const Color(0xFF444B9B),
            ],
            stops: const [0, 1],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 50),
          child: Stack(
            children: [
              Row(
                children: [
                  const SizedBox(width: 70),
                  Image.asset(FilePaths.ladder),
                  Expanded(
                    child: CustomScrollView(
                      reverse: true,
                      slivers: [
                        SliverList.builder(
                          itemCount: bookList.length,
                          key: keys,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: ListItem(
                                bookList: bookList,
                                index: index,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Image.asset(FilePaths.ladder),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 300),
                        child: Image.asset(
                          FilePaths.ladderFox,
                          width: 80,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final List bookList;
  final int index;

  const ListItem({super.key, required this.bookList, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 156, 156, 156).withOpacity(0.15),
      ),
      child: Text(
        bookList[index],
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}
