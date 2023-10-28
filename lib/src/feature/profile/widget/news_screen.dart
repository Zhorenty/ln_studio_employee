import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/assets/generated/assets.gen.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';
import 'package:ln_employee/src/common/widget/animated_button.dart';
import 'package:ln_employee/src/feature/initialization/logic/initialization_steps.dart';

import 'package:ln_employee/src/feature/profile/bloc/news/news_bloc.dart';

import 'package:ln_employee/src/feature/profile/bloc/news/news_state.dart';

///
class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBLoC, NewsState>(
      builder: (context, state) => Scaffold(
        backgroundColor: context.colorScheme.onBackground,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
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
                        imageUrl: '$kBaseUrl/${state.news[index].photo!}',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                      text: subtitle,
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
  });

  final String imageUrl;

  final bool hasPhoto;

  @override
  Widget build(BuildContext context) {
    return hasPhoto
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) => ColoredBox(
              color: context.colorScheme.onBackground,
              child: Assets.images.logoWhite.image(
                fit: BoxFit.contain,
              ),
            ),
          )
        : Assets.images.logoWhite.image(
            fit: BoxFit.contain,
          );
  }
}
