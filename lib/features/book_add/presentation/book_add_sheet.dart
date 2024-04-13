import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxaac_app/features/book_search/domain/book_model.dart';
import 'package:foxaac_app/shared/utils/logger.dart';
import 'package:foxaac_app/shared/widget/book_state_button.dart';
import 'package:foxaac_app/shared/widget/main_button.dart';
import 'package:foxaac_app/styles/styles.dart';
import 'package:intl/intl.dart';

class BookAddSheet extends ConsumerWidget {
  const BookAddSheet({
    super.key,
    required this.book,
  });

  final BookModel book;
  static final AppStyle _style = AppStyle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    int remainingCharacters = 140;
    final dates = ref.watch(datesProvider);
    FocusNode textFocus = FocusNode();

    logger.d('watch!: ${dates.startDate}, ${dates.endDate}');
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 20,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          logger.d('onTap');
          textFocus.unfocus();
        },
        child: Wrap(
          runSpacing: 20,
          children: [
            Text(
              book.title.split('(')[0],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.thumbsUp,
                  color: Colors.grey[700],
                ),
                const SizedBox(width: 20),
                Icon(
                  FontAwesomeIcons.thumbsDown,
                  color: Colors.grey[700],
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BookStateButton(
                  text: '읽은 책',
                  isActive: true,
                ),
                BookStateButton(text: '읽고 싶은 책'),
                BookStateButton(text: '읽고 있는 책'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('한줄평'),
                const SizedBox(height: 5),
                TextField(
                  focusNode: textFocus,
                  controller: controller,
                  maxLines: 4,
                  maxLength: 140,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xffD7D7D7),
                      ),
                    ),
                    hintText: '내용을 입력해 주세요! (최대 140자)',
                    counterText: '$remainingCharacters/140',
                    counterStyle: TextStyle(
                      color:
                          remainingCharacters < 0 ? Colors.red : Colors.black,
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('독서 기간'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showCustomDateRangePicker(
                          context,
                          dismissible: true,
                          minimumDate:
                              DateTime.now().subtract(const Duration(days: 30)),
                          maximumDate:
                              DateTime.now().add(const Duration(days: 30)),
                          endDate: DateTime.parse(
                            dates.endDate == ''
                                ? DateTime.now().toString()
                                : dates.endDate,
                          ),
                          startDate: DateTime.parse(
                            dates.startDate == ''
                                ? DateTime.now().toString()
                                : dates.startDate,
                          ),
                          backgroundColor: Colors.white,
                          primaryColor: const Color.fromARGB(255, 32, 32, 32),
                          onApplyClick: (start, end) {
                            ref.read(datesProvider.notifier).update(
                                  (state) => Dates(
                                    startDate: start.toString(),
                                    endDate: end.toString(),
                                  ),
                                );
                          },
                          onCancelClick: () {},
                        );
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                    Expanded(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: _style.colors.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            dates.startDate == ''
                                ? ''
                                : DateFormat('yy년 MM월 dd일').format(
                                    DateTime.parse(dates.startDate),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text('부터'),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: _style.colors.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            dates.endDate == ''
                                ? ''
                                : DateFormat('yy년 MM월 dd일').format(
                                    DateTime.parse(dates.endDate),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text('까지'),
                  ],
                ),
              ],
            ),
            const Row(children: [MainButton(text: '완료')]),
          ],
        ),
      ),
    );
  }
}

final datesProvider = StateProvider.autoDispose<Dates>(
  (ref) => Dates(startDate: '', endDate: ''),
);

class Dates {
  final String startDate;
  final String endDate;

  Dates({
    required this.startDate,
    required this.endDate,
  });
}
