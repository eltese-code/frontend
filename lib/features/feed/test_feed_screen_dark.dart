import 'package:flutter/material.dart';

class TestFeedScreenDark extends StatefulWidget {
  const TestFeedScreenDark({super.key});

  @override
  State<TestFeedScreenDark> createState() => _TestFeedScreenDarkState();
}

class _TestFeedScreenDarkState extends State<TestFeedScreenDark> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keys = GlobalKey<AnimatedListState>();
    final List nickList = ['강양지', '야엉', '머', '쭈', '디디'];
    final List profileList = [
      'https://kin-phinf.pstatic.net/20220910_23/1662814623235WWQpE_JPEG/FE054733-3554-475D-9E18-054509B8D11F.jpeg?type=w750',
      'https://tse3.mm.bing.net/th?id=OIP.XWFJoIf_LZ6KFnoYjnZJYAHaE7&pid=Api&P=0&h=220',
      'https://tse4.mm.bing.net/th?id=OIP.Ky2F5BXRfSuN7RyLdeKO4QEsDh&pid=Api&P=0&h=220',
      'https://tse3.mm.bing.net/th?id=OIP.mlSnsNkkqRVoqT_C2JMvnAHaHU&pid=Api&P=0&h=220',
      'https://tse2.mm.bing.net/th?id=OIP.jjS15p4RBv9lk3h025azoQHaFF&pid=Api&P=0&h=220',
    ];
    final List bookList = [
      'https://tse2.mm.bing.net/th?id=OIP.v8kjlNPOAyXKRCFNux2I3AHaK3&pid=Api&P=0&h=220',
      'https://contents.kyobobook.co.kr/pdt/9791167372864.jpg',
      'https://shopping-phinf.pstatic.net/main_3248204/32482041666.20220527084837.jpg',
      'https://cdn.ikoreanspirit.com/news/photo/202110/65387_87648_156.jpg',
      'http://image.yes24.com/goods/111384746/XL',
    ];

    return Stack(
      children: [
        // SizedBox(
        //   width: size.width,
        //   height: size.height,
        //   child: Image.asset(
        //     'assets/images/background/feed_background.png',
        //   ),
        // ),
        // BackdropFilter(
        //   filter: ImageFilter.blur(sigmaX: 20, sigmaY: 30),
        //   child: const SizedBox(),
        // ),
        Container(
          width: size.width,
          height: size.height,
          color: Colors.black,
        ),
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromARGB(255, 34, 38, 78).withOpacity(.5),
                const Color(0xFF444B9B).withOpacity(1)
              ],
              stops: const [0, 1],
            ),
          ),
        ),
        CustomScrollView(
          slivers: <Widget>[
            // SliverAppBar(
            //   expandedHeight: 50.0,
            //   floating: true,
            //   elevation: 0,
            //   backgroundColor: Colors.white.withOpacity(0.2),
            //   // statusBarBrightness: Brightness.dark,

            //   systemOverlayStyle: const SystemUiOverlayStyle(
            //     // 상태 표시줄 밝기 (선택 사항)
            //     statusBarIconBrightness: Brightness.light, // 안드로이드용
            //     statusBarBrightness: Brightness.light, // iOS용
            //   ),
            //   title: const Text(
            //     '친구의 독서',
            //     style: TextStyle(color: Colors.black),
            //   ),
            // ),
            const SliverPadding(padding: EdgeInsets.only(top: 60)),
            SliverList.builder(
              itemCount: nickList.length,
              key: keys,
              itemBuilder: (BuildContext context, int index) {
                return ListItem(
                  profileList: profileList,
                  nickList: nickList,
                  bookList: bookList,
                  index: index,
                );
              },
            ),
          ],
        ),
      ],
    );
    //   ),
    // );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.profileList,
    required this.nickList,
    required this.bookList,
    required this.index,
  });

  final List profileList;
  final List nickList;
  final List bookList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white.withOpacity(0.055),
          boxShadow: const [
            // BoxShadow(
            //   color: const Color(0xFFE2E2E2).withOpacity(0.6),
            //   spreadRadius: 5.0,
            //   blurRadius: 7.0,
            // ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(profileList[index]),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nickList[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade50,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '10월 28일 토요일',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '추천',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(thickness: 0.5, color: Colors.white),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage(bookList[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      height: 170,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '지구 끝의 온실',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '김초엽',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                '사랑은 자해다...',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300]!.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text('✨🥹👍🏻'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            const Positioned(
              bottom: 0,
              right: 0,
              child: Text('❤️'),
            ),
          ],
        ),
      ),
    );
  }
}
