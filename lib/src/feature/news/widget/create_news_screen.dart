import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';
import 'package:ln_employee/src/common/widget/custom_text_field.dart';
import 'package:ln_employee/src/common/widget/overlay/message_popup.dart';
import 'package:ln_employee/src/common/widget/picker_popup.dart';
import 'package:ln_employee/src/feature/news/bloc/news_bloc.dart';
import 'package:ln_employee/src/feature/news/bloc/news_event.dart';

class CreateNewsScreen extends StatefulWidget {
  const CreateNewsScreen({super.key});

  @override
  State<CreateNewsScreen> createState() => _CreateNewsScreenState();
}

class _CreateNewsScreenState extends State<CreateNewsScreen> {
  ///
  File? image;

  ///
  final _formKey = GlobalKey<FormState>();

  ///
  late final TextEditingController _titleController;
  late final FocusNode _titleFocusNode;

  late final TextEditingController _descriptionController;
  late final FocusNode _descriptionFocusNode;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _titleFocusNode = FocusNode();

    _descriptionController = TextEditingController();
    _descriptionFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleFocusNode.dispose();

    _descriptionController.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasImage = image != null;

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: context.colorScheme.onBackground,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              stretch: true,
              snap: true,
              floating: true,
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SizedBox(
                      height: 35,
                      width: 35,
                      child: IconButton.filled(
                        // Padding for centering icon
                        padding: const EdgeInsets.only(),
                        icon: Icon(
                          Icons.add_rounded,
                          color: context.colorScheme.onBackground,
                        ),
                        onPressed: () => MessagePopup.bottomSheet(
                          context,
                          'Выберите источник фото',
                          additional: [
                            PickerPopup(
                              onPickCamera: () => pickImage(ImageSource.camera)
                                  .then((_) => context.pop()),
                              onPickGallery: () =>
                                  pickImage(ImageSource.gallery)
                                      .then((_) => context.pop()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                background: hasImage
                    ? Image.file(
                        image!,
                        fit: BoxFit.cover,
                      )
                    : ColoredBox(
                        color: context.colorScheme.background,
                        child: Icon(
                          Icons.photo_size_select_large_rounded,
                          color: context.colorScheme.primaryContainer,
                          size: 100,
                        ),
                      ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList.list(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      'Название',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: _titleController,
                    focusNode: _titleFocusNode,
                    onTapOutside: (_) => _titleFocusNode.hasFocus
                        ? _titleFocusNode.unfocus()
                        : null,
                    validator: _emptyValidator,
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      'Содержание',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: _descriptionController,
                    focusNode: _descriptionFocusNode,
                    onTapOutside: (_) => _descriptionFocusNode.hasFocus
                        ? _descriptionFocusNode.unfocus()
                        : null,
                    validator: _emptyValidator,
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 22),
          child: ElevatedButton(
            onPressed: context.read<NewsBLoC>().state.isProcessing
                ? null
                : () {
                    if (image == null) {
                      MessagePopup.error(context, 'Вы должны выбрать фото');
                    } else {
                      if (_formKey.currentState!.validate()) {
                        context.read<NewsBLoC>().add(
                              NewsEvent.create(
                                title: _titleController.text,
                                description: _descriptionController.text,
                                photo: image!,
                              ),
                            );
                        context.read<NewsBLoC>().add(
                              const NewsEvent.fetchAll(),
                            );
                        context.pop();
                      }
                    }
                  },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              fixedSize: Size(MediaQuery.sizeOf(context).width - 50, 50),
              backgroundColor: context.colorScheme.primary,
            ),
            child: Text(
              'Сохранить',
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 17.5,
                fontFamily: FontFamily.geologica,
                color: context.colorScheme.onBackground,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }

  /// Empty value validator.
  String? _emptyValidator(String? value) =>
      value!.isEmpty ? 'Обязательное поле' : null;
}
