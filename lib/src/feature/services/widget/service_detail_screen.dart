import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// {@template service_detail_screen}
/// ServiceDetailScreen widget.
/// {@endtemplate}
class ServiceDetailScreen extends StatefulWidget {
  /// {@macro service_detail_screen}
  const ServiceDetailScreen({super.key});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

/// State for widget ServiceDetailScreen.
class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Service Detail')), body: const _Body());
}
