import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/feature/staff/model/mock.dart';
import '/src/feature/timetable/widget/salon_choice_widget.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: false,
          title: Text(
            'Сотрудники',
            style: context.textTheme.titleLarge!.copyWith(
              color: context.colorScheme.primary,
              fontFamily: FontFamily.geologica,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4, top: 4),
              child: IconButton(
                icon: Icon(
                  Icons.more_horiz_outlined,
                  color: context.colorScheme.primary,
                ),
                onPressed: () {},
              ),
            ),
          ],
          floating: true,
          pinned: true,
          stretch: true,
          bottom: const PreferredSize(
            preferredSize: Size(300, 70),
            child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 15),
              child: SalonChoiceWidget(),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverList.builder(
            itemCount: $staff.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: context.colorScheme.secondary,
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            '${$staff[index].user.firstName} ${$staff[index].user.lastName}',
                            style: context.textTheme.titleLarge?.copyWith(
                              fontFamily: FontFamily.geologica,
                            ),
                          ),
                          Text(
                            $staff[index].jobPlace.name,
                            style: context.textTheme.titleSmall?.copyWith(
                              fontFamily: FontFamily.geologica,
                              color: const Color(0xFFA8A6A6),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const StarRating(rating: 3)
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: const Icon(Icons.edit),
                      onTap: () => context.go(
                        '/staff/employee/${$staff[index].id}',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 64),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Добавить сотрудника',
                style: context.textTheme.titleMedium!.copyWith(
                  color: context.colorScheme.background,
                  fontFamily: FontFamily.geologica,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

///
class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.rating,
    this.size = 24.0,
  });

  ///
  final int rating;

  ///
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          size: size,
          color: index < rating ? context.colorScheme.primary : Colors.grey,
        ),
      ),
    );
  }
}
