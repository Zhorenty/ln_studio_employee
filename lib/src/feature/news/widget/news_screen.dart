import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/widget/custom_snackbar.dart';
import 'package:ln_employee/src/feature/news/bloc/news_event.dart';

import '../bloc/news_bloc.dart';
import '../bloc/news_state.dart';
import '/src/common/assets/generated/assets.gen.dart';
import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';
import '/src/feature/initialization/logic/initialization_steps.dart';

///
class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsBLoC, NewsState>(
      listener: (context, state) => state.hasError
          ? CustomSnackBar.showError(context, message: state.message)
          : null,
      builder: (context, state) => Scaffold(
        backgroundColor: context.colorScheme.onBackground,
        body: SafeArea(
          child: RefreshIndicator.adaptive(
            onRefresh: () async =>
                context.read<NewsBLoC>()..add(const NewsEvent.fetchAll()),
            edgeOffset: 100,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: context.pop,
                  ),
                  title: Text(
                    'Новости',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList.separated(
                    itemCount: state.news.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) => AnimatedButton(
                      onPressed: () => context.goNamed(
                        'news_edit',
                        extra: state.news[index],
                      ),
                      child: NewsContainer(
                        title: state.news[index].title,
                        subtitle: state.news[index].description,
                        image: CustomNetworkImage(
                          hasPhoto: state.news[index].photo != null,
                          imageUrl:
                              '$kBaseUrl/${state.news[index].photo ?? ''}',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: context.colorScheme.primary,
          child: const Icon(Icons.add, size: 28),
          onPressed: () => context.goNamed('news_create'),
        ),
      ),
    );
  }
}

class NewsContainer extends StatelessWidget {
  const NewsContainer({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  ///
  final Widget image;

  ///
  final String title;

  ///
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0XFF272727)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 120,
            width: 175,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              child: image,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: title),
                    const TextSpan(text: '\n'),
                    TextSpan(
                      text: subtitle.replaceAll('\\n', '\n'),
                      style: context.textTheme.bodySmall?.copyWith(
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                  ],
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontFamily: FontFamily.geologica,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.hasPhoto = false,
    this.placeholder,
  });

  final String imageUrl;

  final bool hasPhoto;

  final Widget Function(BuildContext, String)? placeholder;

  @override
  Widget build(BuildContext context) {
    return hasPhoto
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: placeholder ??
                (_, __) => ColoredBox(
                      color: context.colorScheme.onBackground,
                      child: Assets.images.logoWhite.image(
                        fit: BoxFit.contain,
                      ),
                    ),
          )
        : Assets.images.logoWhite.image(
            fit: BoxFit.cover,
          );
  }
}
