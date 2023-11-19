import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/common/utils/extensions/date_time_extension.dart';
import 'package:ln_employee/src/common/widget/information_widget.dart';
import 'package:ln_employee/src/common/widget/custom_snackbar.dart';
import 'package:ln_employee/src/common/widget/shimmer.dart';
import 'package:ln_employee/src/feature/book_history/bloc/booking_history_event.dart';
import 'package:ln_employee/src/feature/book_history/model/booking.dart';
import 'package:ln_employee/src/feature/book_history/widget/components/history_item_card.dart';

import '../bloc/booking_history_bloc.dart';
import '../bloc/booking_history_state.dart';
import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/feature/initialization/widget/dependencies_scope.dart';

///
class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingHistoryBloc(
        repository: DependenciesScope.of(context).bookingHistoryRepository,
      )..add(BookingHistoryEvent.fetchByEmployee(id: id)),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: context.colorScheme.onBackground,
          appBar: AppBar(
            title: Text(
              'Мои записи',
              style: context.textTheme.titleLarge?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.sizeOf(context).width, 60),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16).add(
                  const EdgeInsets.only(bottom: 8),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: context.colorScheme.background,
                  border: Border.all(color: const Color(0xFF272727)),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: context.colorScheme.onBackground,
                  labelColor: context.colorScheme.onBackground,
                  unselectedLabelColor: context.colorScheme.secondary,
                  labelStyle: context.textTheme.bodyLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                  unselectedLabelStyle: context.textTheme.bodyLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                  tabAlignment: TabAlignment.fill,
                  overlayColor: MaterialStatePropertyAll(
                    context.colorScheme.scrim,
                  ),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: context.colorScheme.primary,
                  ),
                  tabs: const [
                    Tab(text: 'Предстоящие'),
                    Tab(text: 'Прошедшие'),
                  ],
                ),
              ),
            ),
          ),
          body: BlocConsumer<BookingHistoryBloc, BookingHistoryState>(
            listener: (context, state) => state.hasError
                ? CustomSnackBar.showError(context, message: state.error)
                : null,
            builder: (context, state) {
              if (state.isProcessing && !state.hasBookingHistory) {
                final size = MediaQuery.sizeOf(context);
                return Center(
                  child: Shimmer(
                    size: Size(size.width - 32, size.height / 1.5),
                  ),
                );
              }
              return TabBarView(
                children: [
                  _BookingList(
                    id: id,
                    bookingHistory: state.upcomingEvents,
                  ),
                  _BookingList(
                    id: id,
                    bookingHistory: state.pastEvents,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// TODO: Make function
class _BookingList extends StatelessWidget {
  const _BookingList({
    required this.id,
    required this.bookingHistory,
  });

  final int id;

  final List<BookingModel> bookingHistory;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      displacement: 16,
      onRefresh: () async => context.read<BookingHistoryBloc>().add(
            BookingHistoryEvent.fetchByEmployee(id: id),
          ),
      child: bookingHistory.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                final item = bookingHistory[index];
                return HistoryItemCard(
                  phone: item.client.user.phone,
                  title: item.client.user.fullName,
                  subtitle: item.service.name,
                  dateAt: item.dateAt.defaultFormat(),
                  timeblock: createTimeWithDuration(
                    item.timeblock.time,
                    item.service.duration!,
                  ),
                );
              },
            )
          : InformationWidget.empty(
              title: 'Предстоящих записей нет',
              description: null,
            ),
    );
  }

  ///
  String createTimeWithDuration(String serverTime, int duration) {
    DateTime parsedTime = DateTime.parse('2022-01-01 $serverTime');
    DateTime endTime = parsedTime.add(Duration(minutes: duration));

    String formattedStartTime =
        '${parsedTime.hour}:${parsedTime.minute.toString().padLeft(2, '0')}:${parsedTime.second.toString().padLeft(2, '0')}';
    String formattedEndTime =
        '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}:${endTime.second.toString().padLeft(2, '0')}';

    return '${formattedStartTime.substring(0, formattedStartTime.length - 3)} - ${formattedEndTime.substring(0, formattedEndTime.length - 3)}';
  }
}
