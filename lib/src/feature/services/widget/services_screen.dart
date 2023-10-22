import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';
import 'package:ln_employee/src/common/widget/animated_button.dart';
import 'package:ln_employee/src/common/widget/shimmer.dart';
import 'package:ln_employee/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:ln_employee/src/feature/services/bloc/category_bloc.dart';
import 'package:ln_employee/src/feature/services/bloc/category_event.dart';
import 'package:ln_employee/src/feature/services/bloc/category_state.dart';
import 'package:ln_employee/src/feature/services/model/service.dart';

///
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(
        repository: DependenciesScope.of(context).servicesRepository,
      )..add(const CategoryEvent.fetchServiceCategories()),
      child: Scaffold(
        backgroundColor: context.colorScheme.onBackground,
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: context.colorScheme.onBackground,
                  pinned: true,
                  title: Text(
                    'Услуги',
                    style: context.textTheme.titleLarge!.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                  leading: AnimatedButton(
                    child: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () => context.pop(),
                  ),
                ),
                SliverAnimatedOpacity(
                  opacity: state.hasCategory ? 1 : .5,
                  duration: const Duration(milliseconds: 400),
                  sliver: state.hasCategory
                      ? SliverList.builder(
                          itemCount: state.categoryWithServices.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: GestureDetector(
                                child: Column(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: Color(0xFF272727),
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.zero,
                                      child: ExpansionTile(
                                        backgroundColor:
                                            context.colorScheme.background,
                                        collapsedBackgroundColor:
                                            context.colorScheme.background,
                                        title: Text(
                                          state
                                              .categoryWithServices[index].name,
                                          style: context.textTheme.bodyLarge
                                              ?.copyWith(
                                            fontFamily: FontFamily.geologica,
                                          ),
                                        ),
                                        children: [
                                          ...state.categoryWithServices[index]
                                              .service
                                              .map(
                                            (service) => ServiceCard(
                                              service: service,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        ElevatedButton.icon(
                                          icon: const Icon(Icons.edit),
                                          label: const Text('Редаутировать'),
                                          onPressed: () {},
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton.icon(
                                          icon: const Icon(Icons.delete),
                                          label: const Text('Удалить'),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              Colors.redAccent
                                                  .withOpacity(0.75),
                                            ),
                                          ),
                                          onPressed: () {},
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          sliver: SliverList.separated(
                            itemCount: 5,
                            itemBuilder: (context, index) =>
                                const SkeletonServiceCard(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                          ),
                        ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.plus_one),
          onPressed: () {},
        ),
      ),
    );
  }
}

class SkeletonServiceCard extends StatelessWidget {
  const SkeletonServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF272727),
        ),
      ),
      child: const Shimmer(
        size: Size(double.infinity, 57),
        cornerRadius: 16,
      ),
    );
  }
}

///
class ServiceCard extends StatefulWidget {
  const ServiceCard({
    super.key,
    required this.service,
  });

  ///
  final ServiceModel service;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  ///
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed('service-detail'),
      child: Container(
        decoration: BoxDecoration(color: context.colorScheme.background),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8).add(
          const EdgeInsets.only(right: 16),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AnimatedButton(
                //   padding: const EdgeInsets.only(right: 4, top: 2),
                //   onPressed: () {},
                //   child: const Icon(Icons.edit, size: 20),
                // ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.service.name,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontFamily: FontFamily.geologica,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Стоимость: ',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.primaryContainer,
                                fontFamily: FontFamily.geologica,
                              ),
                            ),
                            TextSpan(
                              text: widget.service.price.toString(),
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.secondary,
                                fontFamily: FontFamily.geologica,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedButton(
                  padding: const EdgeInsets.only(right: 4, top: 2),
                  onPressed: () => setState(() => expanded = !expanded),
                  child: const Icon(Icons.info_outline, size: 20),
                ),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 750),
              curve: Curves.linearToEaseOut,
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              child: expanded
                  ? Padding(
                      padding: const EdgeInsets.only(top: 4, left: 10),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.service.description,
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontFamily: FontFamily.geologica,
                                color: context.colorScheme.primaryContainer,
                              ),
                            ),
                            TextSpan(
                              text: '\nДлительность процедуры: '
                                  '${widget.service.duration} минут',
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontFamily: FontFamily.geologica,
                                color: context.colorScheme.primaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
