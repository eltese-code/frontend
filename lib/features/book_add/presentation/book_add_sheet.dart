import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foxaac_app/features/book_add/data/add_book_model.dart';
import 'package:foxaac_app/features/book_add/presentation/animation_button.dart';
import 'package:foxaac_app/features/book_search/domain/book_model.dart';
import 'package:foxaac_app/shared/widget/book_state_button.dart';
import 'package:foxaac_app/shared/widget/main_button.dart';
import 'package:foxaac_app/styles/styles.dart';
import 'package:intl/intl.dart';

class BookAddSheet extends ConsumerStatefulWidget {
  const BookAddSheet({
    super.key,
    required this.bookModel,
  });

  final BookModel bookModel;
  static final AppStyle _style = AppStyle();

  @override
  ConsumerState<BookAddSheet> createState() => _BookAddSheetState();
}

class _BookAddSheetState extends ConsumerState<BookAddSheet> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int remainingCharacters = ref.watch(_remainingCharactersProvider);
    FocusNode textFocus = FocusNode();

    final book = ref.watch(_bookProvider(widget.bookModel));

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 20,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: textFocus.unfocus,
        child: Wrap(
          runSpacing: 20,
          children: [
            Text(
              book.bookTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                renderThumbIconButton(
                  ref,
                  bookModel: widget.bookModel,
                  book: book,
                ),
                const SizedBox(width: 20),
                renderThumbIconButton(
                  ref,
                  bookModel: widget.bookModel,
                  book: book,
                  isTumbDown: true,
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BookStateButton(text: '읽은 책', isActive: true),
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
                  controller: _textEditingController,
                  maxLines: 5,
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
                  onChanged: (_) {
                    ref.read(_remainingCharactersProvider.notifier).update(
                          (state) => (140 - _textEditingController.text.length),
                        );
                  },
                ),
                const Text('독서 기간'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDatePicker(
                          context,
                          ref,
                          book: book,
                          onApplyClick: (start, end) {
                            ref
                                .read(_bookProvider(widget.bookModel).notifier)
                                .update(
                                  (state) => book.copyWith(
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
                    renderDate(date: book.startDate),
                    const SizedBox(width: 5),
                    const Text('부터'),
                    const SizedBox(width: 20),
                    renderDate(date: book.endDate),
                    const Text('까지'),
                  ],
                ),
              ],
            ),
            AnimationButton(
              upperBound: 0.02,
              isDone: true,
              onTap: () {
                ref.read(_bookProvider(widget.bookModel).notifier).update(
                      (state) => book.copyWith(
                          bookComment: _textEditingController.text),
                    );
              },
              child: const MainButton(
                text: '완료',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

renderThumbIconButton(
  WidgetRef ref, {
  required BookModel bookModel,
  required AddBookModel book,
  bool isTumbDown = false,
}) {
  BookPreference bookPreference =
      isTumbDown ? BookPreference.DISLIKE : BookPreference.PREFER;

  return AnimationButton(
    onTap: () {
      ref.read(_bookProvider(bookModel).notifier).update(
            (state) => book.copyWith(
              bookPreference: bookPreference,
            ),
          );
    },
    child: Icon(
      isTumbDown ? FontAwesomeIcons.thumbsDown : FontAwesomeIcons.thumbsUp,
      color: book.bookPreference == bookPreference
          ? BookAddSheet._style.colors.primaryColor
          : Colors.grey[700],
    ),
  );
}

void showDatePicker(
  BuildContext context,
  WidgetRef ref, {
  required AddBookModel book,
  required dynamic Function(DateTime, DateTime) onApplyClick,
  required dynamic Function() onCancelClick,
}) {
  showCustomDateRangePicker(
    context,
    dismissible: true,
    minimumDate: DateTime.now().subtract(const Duration(days: 30)),
    maximumDate: DateTime.now().add(const Duration(days: 30)),
    endDate: DateTime.parse(
      book.endDate == '' ? DateTime.now().toString() : book.endDate,
    ),
    startDate: DateTime.parse(
      book.startDate == '' ? DateTime.now().toString() : book.startDate,
    ),
    backgroundColor: Colors.white,
    primaryColor: const Color.fromARGB(255, 32, 32, 32),
    onApplyClick: onApplyClick,
    onCancelClick: onCancelClick,
  );
}

renderDate({
  required String date,
}) {
  return Expanded(
    child: Container(
      height: 30,
      decoration: BoxDecoration(
        color: BookAddSheet._style.colors.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          date == ''
              ? ''
              : DateFormat('yy년 MM월 dd일').format(
                  DateTime.parse(date),
                ),
        ),
      ),
    ),
  );
}

final _bookProvider = StateProvider.family.autoDispose<AddBookModel, BookModel>(
  (ref, data) {
    return AddBookModel(
      bookTitle: data.title,
      bookAuthor: data.author,
      bookPreference: BookPreference.INITIAL,
      bookComment: '',
      startDate: '',
      endDate: '',
    );
  },
);

final _remainingCharactersProvider = StateProvider.autoDispose((ref) => 140);
