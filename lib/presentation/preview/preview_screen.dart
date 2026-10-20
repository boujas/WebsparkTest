import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/path_result.dart';
import 'widgets/grid_preview.dart';

@RoutePage()
class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key, required this.result});

  final PathResult result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview screen')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridPreview(result: result),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  result.label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
