import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';
import 'package:ln_employee/src/common/widget/custom_text_field.dart';
import 'package:ln_employee/src/common/widget/overlay/modal_popup.dart';
import 'package:ln_employee/src/feature/initialization/logic/initialization_steps.dart';
import 'package:ln_employee/src/feature/profile/bloc/news/news_bloc.dart';
import 'package:ln_employee/src/feature/profile/bloc/news/news_event.dart';
import 'package:ln_employee/src/feature/profile/model/news.dart';
import 'package:ln_employee/src/feature/profile/widget/news_screen.dart';

class EditNewsScreen extends StatefulWidget {
  const EditNewsScreen({super.key, required this.news});

  final NewsModel news;

  @override
  State<EditNewsScreen> createState() => _EditNewsScreenState();
}

class _EditNewsScreenState extends State<EditNewsScreen> {
  File? image;

  ///
  final _formKey = GlobalKey<FormState>();

  ///
  late final TextEditingController _titleController;

  late final TextEditingController _descriptionController;
  late final FocusNode _descriptionFocusNode;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();

    _descriptionController = TextEditingController();
    _descriptionFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _titleController.dispose();

    _descriptionController.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _titleController.text = widget.news.title;
    _descriptionController.text = widget.news.description;

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: context.colorScheme.onBackground,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'Редактирование новости',
                style: context.textTheme.titleLarge?.copyWith(
                  fontSize: 19,
                  fontFamily: FontFamily.geologica,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    icon: const Icon(Icons.more_horiz_rounded),
                    onPressed: showNewsActions,
                  ),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList.list(
                children: [
                  GestureDetector(
                    onTap: () => pickImage(ImageSource.gallery),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          CustomNetworkImage(
                            hasPhoto: widget.news.photo != null,
                            imageUrl: '$kBaseUrl/${widget.news.photo!}',
                          ),
                          if (image != null)
                            Positioned.fill(
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Название',
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                  CustomTextField(controller: _titleController),
                  const SizedBox(height: 2),
                  Text(
                    'Содержание',
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                  HugeTextField(
                    controller: _descriptionController,
                    focusNode: _descriptionFocusNode,
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 22),
          child: ElevatedButton(
            onPressed: () {
              context.read<NewsBLoC>().add(
                    NewsEvent.edit(
                      news: NewsModel(
                        id: widget.news.id,
                        photo: widget.news.photo,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        isDeleted: widget.news.isDeleted,
                      ),
                    ),
                  );
              if (image != null) {
                context.read<NewsBLoC>().add(
                      NewsEvent.uploadPhoto(id: widget.news.id, photo: image!),
                    );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              fixedSize: Size(
                MediaQuery.sizeOf(context).width - 50,
                50,
              ),
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

  Future<dynamic> showNewsActions() async {
    await ModalPopup.show(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Действия с новостью',
            style: context.textTheme.bodyLarge?.copyWith(
              fontFamily: FontFamily.geologica,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement deleting news
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              fixedSize: Size(
                MediaQuery.sizeOf(context).width - 75,
                35,
              ),
              backgroundColor: context.colorScheme.primary,
            ),
            child: Text(
              'Удалить новость',
              style: context.textTheme.bodyLarge?.copyWith(
                fontFamily: FontFamily.geologica,
                color: context.colorScheme.onBackground,
              ),
            ),
          )
        ],
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
}

/// Large text field for comments.
class HugeTextField extends StatelessWidget {
  const HugeTextField({super.key, this.controller, this.focusNode});

  ///
  final TextEditingController? controller;

  ///
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF272727)),
        ),
        child: TextFormField(
          onTapOutside: (event) =>
              focusNode!.hasFocus ? focusNode?.unfocus() : null,
          controller: controller,
          focusNode: focusNode,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          style: context.textTheme.bodyLarge!.copyWith(
            fontFamily: FontFamily.geologica,
            letterSpacing: 0.5,
          ),
          decoration: InputDecoration(
            isDense: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.colorScheme.scrim),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.colorScheme.scrim),
            ),
          ),
        ),
      ),
    );
  }
}
