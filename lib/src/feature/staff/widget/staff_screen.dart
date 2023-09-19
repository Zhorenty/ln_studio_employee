import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/widget/animated_button.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_bloc.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_state.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/custom_app_bar.dart';
import '/src/common/widget/star_rating.dart';
import '/src/feature/staff/bloc/staff_bloc.dart';
import '/src/feature/staff/bloc/staff_event.dart';
import '/src/feature/staff/bloc/staff_state.dart';

/// {@template staff_screen}
/// Staff screen.
/// {@endtemplate}
class StaffScreen extends StatefulWidget {
  /// {@macro staff_screen}
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  late final StaffBloc staffBloc;

  @override
  void initState() {
    super.initState();
    staffBloc = context.read<StaffBloc>();
    _fetchSalonEmployees();
  }

  void _fetchSalonEmployees() {
    final salonBloc = context.read<SalonBLoC>();
    if (salonBloc.state.currentSalon != null) {
      staffBloc.add(
        StaffEvent.fetchSalonEmployees(salonBloc.state.currentSalon!.id),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SalonBLoC, SalonState>(
      listener: (context, state) {},
      listenWhen: (previous, current) {
        if (previous.currentSalon?.id != current.currentSalon?.id) {
          staffBloc
              .add(StaffEvent.fetchSalonEmployees(current.currentSalon!.id));
        }
        return false;
      },
      child: BlocBuilder<StaffBloc, StaffState>(
        builder: (context, state) => Scaffold(
          body: CustomScrollView(
            slivers: [
              CustomSliverAppBar(title: context.stringOf().employees),
              CupertinoSliverRefreshControl(onRefresh: _refresh),
              if (state.hasStaff) ...[
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverList.builder(
                    itemCount: state.employeeStaff.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 4 + 2),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 4),
                      decoration: BoxDecoration(
                        color: context.colorScheme.onBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: context.colorScheme.secondary,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8 + 2),
                              Text(
                                '${state.employeeStaff[index].userModel.firstName}'
                                ' ${state.employeeStaff[index].userModel.lastName}',
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontFamily: FontFamily.geologica,
                                ),
                              ),
                              Text(
                                state.employeeStaff[index].jobPlaceModel.name,
                                style: context.textTheme.labelMedium?.copyWith(
                                  fontFamily: FontFamily.geologica,
                                  color: context.colorScheme.primaryContainer,
                                ),
                              ),
                              const SizedBox(height: 4),
                              StarRating(
                                initialRating: state.employeeStaff[index].stars,
                              )
                            ],
                          ),
                          const SizedBox.shrink(),
                          AnimatedButton(
                            child: const Icon(Icons.edit, size: 20),
                            onPressed: () {
                              _refresh();
                              context.go(
                                '/staff/employee',
                                extra: state.employeeStaff[index].id,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: GestureDetector(
                    onTap: () => context.goNamed('/create_employee'),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width / 8,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          context.stringOf().addEmployee,
                          style: context.textTheme.titleMedium!.copyWith(
                            color: context.colorScheme.background,
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ] else
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      context.stringOf().noEmployees,
                      style: context.textTheme.titleMedium!.copyWith(
                        fontFamily: FontFamily.geologica,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          floatingActionButton: !state.hasStaff
              ? FloatingActionButton.extended(
                  backgroundColor: context.colorScheme.primary,
                  label: Text(
                    context.stringOf().addEmployee,
                    style: context.textTheme.bodySmall!.copyWith(
                      fontFamily: FontFamily.geologica,
                      color: context.colorScheme.background,
                    ),
                  ),
                  onPressed: () {},
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    final block = context.read<StaffBloc>().stream.first;
    _fetchSalonEmployees();
    await block;
  }
}
