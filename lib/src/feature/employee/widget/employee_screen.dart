import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ln_employee/src/common/assets/generated/assets.gen.dart';
import 'package:ln_employee/src/common/widget/custom_snackbar.dart';
import 'package:ln_employee/src/common/widget/picker_popup.dart';
import 'package:ln_employee/src/feature/employee/bloc/avatar/avatar_bloc.dart';
import 'package:ln_employee/src/feature/employee/bloc/avatar/avatar_event.dart';
import 'package:ln_employee/src/feature/initialization/logic/initialization_steps.dart';
import 'package:ln_employee/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:ln_employee/src/feature/portfolio/bloc/portfolio_bloc.dart';
import 'package:ln_employee/src/feature/portfolio/bloc/portfolio_event.dart';
import 'package:ln_employee/src/feature/portfolio/bloc/potfolio_state.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/field_button.dart';
import '/src/common/widget/header.dart';
import '/src/common/widget/overlay/message_popup.dart';
import '/src/feature/employee/bloc/employee/employee_bloc.dart';
import '/src/feature/employee/bloc/employee/employee_event.dart';
import '/src/feature/employee/bloc/employee/employee_state.dart';
import '/src/feature/employee/bloc/staff/staff_bloc.dart';
import '/src/feature/employee/bloc/staff/staff_event.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import 'components/expanded_app_bar.dart';
import 'components/skeleton_employee_screen.dart';

/// {@template employee_screen}
/// Employee screen.
/// {@endtemplate}
class EmployeeScreen extends StatefulWidget {
  /// {@macro employee_screen}
  const EmployeeScreen({super.key, required this.id});

  /// Employee id.
  final int id;

  @override
  State<EmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EmployeeScreen> {
  // Переменные, которые не должны изменяться при rebuild'е.
  int? clientsCount;
  int? workedDaysCount;

  File? avatar;

  late EmployeeAvatarBloc avatarBloc;
  late PortfolioBloc portfolioBloc;

  @override
  void initState() {
    super.initState();
    avatarBloc = EmployeeAvatarBloc(
      repository: DependenciesScope.of(context).employeeRepository,
    );
    portfolioBloc = PortfolioBloc(
        repository: DependenciesScope.of(context).portfolioRepository)
      ..add(PortfolioEvent.fetch(id: widget.id));
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: avatarBloc),
          BlocProvider.value(value: portfolioBloc),
        ],
        child: BlocConsumer<EmployeeBloc, EmployeeState>(
          listener: (context, state) => state.hasError
              ? CustomSnackBar.showError(context, message: state.error)
              : null,
          builder: (context, state) => Scaffold(
            body: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: state.employee == null ? 0 : 1,
              child: state.employee == null
                  ? const SkeletonEmployeeScreen()
                  : Builder(
                      builder: (context) {
                        final employee = state.employee!;
                        final user = state.employee!.userModel;
                        final dismissed = state.employee!.isDismiss;

                        if (clientsCount == null) {
                          clientsCount = employee.clients;
                          workedDaysCount = employee.workedDays;
                        }

                        return CustomScrollView(
                          slivers: [
                            ExpandedAppBar(
                              imageUrl: state.employee?.userModel.photo != null
                                  ? '$kBaseUrl/${state.employee?.userModel.photo}'
                                  : null,
                              avatar: avatar,
                              additional: [
                                PickerPopup(
                                  onPickCamera: () => pickAvatar(
                                    ImageSource.camera,
                                  )..then((_) {
                                      context.read<EmployeeAvatarBloc>().add(
                                            EmployeeAvatarEvent.uploadAvatar(
                                              id: widget.id,
                                              file: avatar!,
                                            ),
                                          );
                                      context.pop();
                                    }),
                                  onPickGallery: () => pickAvatar(
                                    ImageSource.gallery,
                                  )..then((_) {
                                      context.read<EmployeeAvatarBloc>().add(
                                            EmployeeAvatarEvent.uploadAvatar(
                                              id: widget.id,
                                              file: avatar!,
                                            ),
                                          );
                                      context.pop();
                                    }),
                                ),
                              ],
                              label: user.fullName,
                              title: Text(
                                user.fullName,
                                style: context.textTheme.titleLarge!.copyWith(
                                  fontFamily: FontFamily.geologica,
                                ),
                              ),
                              leading: Text(
                                clientsCount.toString(),
                                style: context.textTheme.titleLarge!.copyWith(
                                  fontFamily: FontFamily.geologica,
                                ),
                              ),
                              trailing: Text(
                                workedDaysCount.toString(),
                                style: context.textTheme.titleLarge!.copyWith(
                                  fontFamily: FontFamily.geologica,
                                ),
                              ),
                              additionalTrailing: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    backgroundColor:
                                        context.colorScheme.primary,
                                    side: const BorderSide(
                                      color: Color(0xFF272727),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    dismissed
                                        ? _reinstatement(employee.id)
                                        : _dismiss(employee.id);
                                    context.pop();
                                    MessagePopup.success(
                                      context,
                                      dismissed
                                          ? 'Вы вернули сотрудника на должность'
                                          : 'Сотрудник успешно уволен',
                                    );
                                  },
                                  child: Text(
                                    dismissed
                                        ? 'Восстановить сотрудника в должности'
                                        : 'Уволить сотрудника',
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      color: context.colorScheme.onBackground,
                                      fontFamily: FontFamily.geologica,
                                    ),
                                  ),
                                ),
                              ],
                              onExit: () {
                                context.pop();
                                _refreshStaff();
                              },
                            ),
                            CupertinoSliverRefreshControl(
                              onRefresh: () => _fetch(employee.id),
                            ),
                            SliverList.list(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.onBackground,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DefaultTextStyle(
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                          color: dismissed
                                              ? const Color(0xFFF45636)
                                              : context.colorScheme.primary,
                                          fontFamily: FontFamily.geologica,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const HeaderWidget(
                                              label: 'Статус сотрудника',
                                              showUnderscore: false,
                                            ),
                                            dismissed
                                                ? const Text('Уволен')
                                                : const Text('Работает')
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const HeaderWidget(
                                        label: 'Портфолио',
                                        showUnderscore: false,
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        height: 110,
                                        width: MediaQuery.sizeOf(context).width,
                                        decoration: BoxDecoration(
                                          color: context.colorScheme.background,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                            color: const Color(0xFF272727),
                                          ),
                                        ),
                                        child: BlocBuilder<PortfolioBloc,
                                            PortfolioState>(
                                          builder: (context, state) => ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              PortfolioContainer(
                                                onTap: () =>
                                                    MessagePopup.bottomSheet(
                                                  context,
                                                  'Выберите источник фото',
                                                  additional: [
                                                    PickerPopup(
                                                      onPickCamera: () =>
                                                          onPick(
                                                        context,
                                                        ImageSource.camera,
                                                      ),
                                                      onPickGallery: () =>
                                                          onPick(
                                                        context,
                                                        ImageSource.gallery,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.add_circle_rounded,
                                                    size: 50,
                                                    color: context.colorScheme
                                                        .primaryContainer,
                                                  ),
                                                ),
                                              ),
                                              ...state.portfolio.map(
                                                (e) => PortfolioContainer(
                                                    onLongPress: () =>
                                                        onLongPress(
                                                          context,
                                                          e.id,
                                                        ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            '$kBaseUrl/${e.photo}',
                                                        fit: BoxFit.cover,
                                                        placeholder: (_, __) =>
                                                            ColoredBox(
                                                          color: context
                                                              .colorScheme
                                                              .onBackground,
                                                          child: Assets
                                                              .images.logoWhite
                                                              .image(
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      FieldButton(
                                        label: 'Редактировать',
                                        onTap: () => context.goNamed(
                                          'employee_edit',
                                          pathParameters: {
                                            'id': employee.id.toString(),
                                          },
                                        ),
                                        controller: TextEditingController(),
                                      ),
                                      FieldButton(
                                        controller: TextEditingController(),
                                        label: 'График работы',
                                        onTap: () => context.goNamed(
                                          'employee_timetable',
                                          pathParameters: {
                                            'id': employee.id.toString(),
                                            'salonId': context
                                                .read<SalonBLoC>()
                                                .state
                                                .currentSalon!
                                                .id
                                                .toString()
                                          },
                                        ),
                                      ),
                                      FieldButton(
                                        controller: TextEditingController(),
                                        label: 'Записи',
                                        onTap: () => context.goNamed(
                                          'employee_clients',
                                          pathParameters: {
                                            'id': employee.id.toString(),
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ),
        ),
      );

  void onPick(BuildContext context, ImageSource source) => pickPortfolio(source)
    ..then(
      (portfolio) {
        if (portfolio != null) {
          context.read<PortfolioBloc>().add(
                PortfolioEvent.addPhoto(
                  id: widget.id,
                  photo: portfolio,
                ),
              );
          context.pop();
        }
      },
    );

  void onLongPress(BuildContext context, int id) => MessagePopup.bottomSheet(
        context,
        'Действия с портфолио',
        additional: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              fixedSize: Size(MediaQuery.sizeOf(context).width - 75, 35),
              backgroundColor: context.colorScheme.primary,
            ),
            onPressed: () {
              context.read<PortfolioBloc>().add(
                    PortfolioEvent.delete(id: id),
                  );
              context.pop();
            },
            child: Text(
              'Удалить портфолио',
              style: context.textTheme.bodyLarge?.copyWith(
                fontFamily: FontFamily.geologica,
                color: context.colorScheme.onBackground,
              ),
            ),
          ),
        ],
      );

  Future pickAvatar(ImageSource source) async {
    try {
      final avatar = await ImagePicker().pickImage(source: source);
      if (avatar == null) return;

      final imageTemporary = File(avatar.path);
      setState(() => this.avatar = imageTemporary);
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }

  // ignore: body_might_complete_normally_nullable
  Future<File?> pickPortfolio(ImageSource source) async {
    try {
      final portfolio = await ImagePicker().pickImage(source: source);
      if (portfolio != null) {
        return File(portfolio.path);
      }
      return null;
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }

  /// Dismiss employee by [id].
  Future<void> _dismiss(int id) async =>
      context.read<EmployeeBloc>().add(EmployeeEvent.dismiss(id: id));

  /// Dismiss employee by [id].
  void _reinstatement(int id) =>
      context.read<EmployeeBloc>().add(EmployeeEvent.reinstatement(id: id));

  /// Fetch employee by [id].
  Future<void> _fetch(int id) async =>
      context.read<EmployeeBloc>().add(EmployeeEvent.fetch(id: id));

  /// Refresh all employee's.
  Future<void> _refreshStaff() async {
    final block = context.read<StaffBloc>().stream.first;
    final salonBloc = context.read<SalonBLoC>();
    final staffBloc = context.read<StaffBloc>();
    if (salonBloc.state.currentSalon != null) {
      staffBloc.add(
        StaffEvent.fetchSalonEmployees(salonBloc.state.currentSalon!.id),
      );
    }
    await block;
  }
}

///
class PortfolioContainer extends StatelessWidget {
  const PortfolioContainer({
    super.key,
    this.child,
    this.onTap,
    this.onLongPress,
  });

  ///
  final Widget? child;

  ///
  final void Function()? onTap;

  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: 95,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.colorScheme.onBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF272727),
          ),
        ),
        child: child,
      ),
    );
  }
}
