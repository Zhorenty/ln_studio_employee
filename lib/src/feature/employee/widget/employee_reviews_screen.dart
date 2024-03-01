import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';
import 'package:ln_employee/src/common/widget/information_widget.dart';
import 'package:ln_employee/src/feature/employee/bloc/reviews/employee_reviews_bloc.dart';
import 'package:ln_employee/src/feature/employee/bloc/reviews/employee_reviews_event.dart';
import 'package:ln_employee/src/feature/employee/bloc/reviews/employee_reviews_state.dart';
import 'package:ln_employee/src/feature/employee/widget/components/review_container.dart';
import 'package:ln_employee/src/feature/initialization/widget/dependencies_scope.dart';

/// {@template employee_reviews_screen}
/// EmployeeReviewsScreen widget.
/// {@endtemplate}
class EmployeeReviewsScreen extends StatefulWidget {
  /// {@macro employee_reviews_screen}
  const EmployeeReviewsScreen({super.key, required this.employeeId});

  final int employeeId;

  @override
  State<EmployeeReviewsScreen> createState() => _EmployeeReviewsScreenState();
}

/// State for widget EmployeeReviewsScreen.
class _EmployeeReviewsScreenState extends State<EmployeeReviewsScreen> {
  late final EmployeeReviewsBLoC employeeReviewsBLoC;

  @override
  void initState() {
    super.initState();
    employeeReviewsBLoC = EmployeeReviewsBLoC(
        repository: DependenciesScope.of(context).employeeRepository)
      ..add(
        EmployeeReviewsEvent.fetchReviews(widget.employeeId),
      );
  }

  @override
  void dispose() {
    employeeReviewsBLoC.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colorScheme.onBackground,
        body: RefreshIndicator.adaptive(
          onRefresh: () async => employeeReviewsBLoC.add(
            EmployeeReviewsEvent.fetchReviews(widget.employeeId),
          ),
          edgeOffset: MediaQuery.sizeOf(context).width * 0.3,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                  'Отзывы',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: BlocBuilder<EmployeeReviewsBLoC, EmployeeReviewsState>(
                    bloc: employeeReviewsBLoC,
                    builder: (context, state) => state.reviews.isEmpty
                        ? Center(
                            child: InformationWidget.empty(
                              description: 'Отзывов пока нет',
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.reviews.length,
                            itemBuilder: (context, index) {
                              final review =
                                  employeeReviewsBLoC.state.reviews[index];
                              return ReviewContainer(
                                title: 'Алевтина',
                                createdAt: review.createdAt,
                                text: review.text,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
