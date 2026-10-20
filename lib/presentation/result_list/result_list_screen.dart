import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/route/app_router.dart';
import '../../domain/entities/path_result.dart';

@RoutePage()
class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key, required this.results});

  final List<PathResult> results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result list screen')),
      body: ListView.separated(
        itemCount: results.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final result = results[index];
          return ListTile(
            title: Text(result.label, textAlign: TextAlign.center),
            onTap: () => context.router.push(PreviewRoute()),
          );
        },
      ),
    );
  }
}