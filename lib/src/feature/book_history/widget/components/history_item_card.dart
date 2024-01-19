import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';
import 'package:ln_employee/src/common/widget/avatar_widget.dart';
import 'package:ln_employee/src/common/widget/overlay/message_popup.dart';
import 'package:ln_employee/src/common/widget/overlay/modal_popup.dart';
import 'package:ln_employee/src/feature/book_history/bloc/booking_history_bloc.dart';
import 'package:ln_employee/src/feature/book_history/bloc/booking_history_event.dart';

///
class HistoryItemCard extends StatelessWidget {
  const HistoryItemCard({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.dateAt,
    required this.timeblock,
    required this.phone,
    required this.isDone,
  });

  ///
  final int id;

  ///
  final String title;

  ///
  final String subtitle;

  ///
  final String dateAt;

  ///
  final String timeblock;

  final String phone;

  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        ModalPopup.show(
          context: context,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Действия с записью',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontFamily: FontFamily.geologica,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fixedSize: Size(MediaQuery.sizeOf(context).width - 75, 45),
                  backgroundColor: context.colorScheme.primary,
                ),
                onPressed: () {
                  // TODO: Booking deletion logic
                },
                child: Text(
                  'Удалить запись',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                    color: context.colorScheme.error,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF272727)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AvatarWidget(radius: 26, title: title),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                        color: context.colorScheme.secondary,
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 13,
                        color: context.colorScheme.primaryContainer,
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(color: Color(0xFF272727)),
            const SizedBox(height: 8),
            Text(
              'Номер телефона:',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 13,
                color: context.colorScheme.secondary,
                fontFamily: FontFamily.geologica,
              ),
            ),
            const SizedBox(height: 2),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: phone));
                MessagePopup.success(context, 'Номер успешно скопирован');
              },
              child: Row(
                children: [
                  Text(
                    phone,
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.colorScheme.secondaryContainer,
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.copy_rounded,
                    size: 15,
                    color: context.colorScheme.secondaryContainer,
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Дата записи:',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 13,
                color: context.colorScheme.secondary,
                fontFamily: FontFamily.geologica,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$timeblock, $dateAt',
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.secondaryContainer,
                fontFamily: FontFamily.geologica,
              ),
            ),
            if (!isDone) ...[
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: context.colorScheme.primary,
                ),
                onPressed: () => context.read<BookingHistoryBloc>().add(
                      BookingHistoryEvent.done(bookingId: id),
                    ),
                child: Text(
                  'Завершить',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                    color: context.colorScheme.onBackground,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
