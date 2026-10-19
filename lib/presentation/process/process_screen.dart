import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import '../../core/route/app_router.dart';
import '../common/primary_button.dart';
import 'process_bloc.dart';
import 'process_event.dart';
import 'process_state.dart';

@RoutePage()
class ProcessScreen extends StatelessWidget {
  const ProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProcessBloc>()..add(const ProcessEvent.started()),
      child: const _ProcessView(),
    );
  }
}

class _ProcessView extends StatelessWidget {
  const _ProcessView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProcessBloc, ProcessState>(
      listenWhen: (prev, curr) =>
      prev.status != curr.status && curr.status == ProcessStatus.sent,
      listener: (context, state) =>
          context.router.push(ResultListRoute()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Process screen')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<ProcessBloc, ProcessState>(
              builder: (context, state) => Column(
                children: [
                  Expanded(child: _Body(state: state)),
                  _BottomAction(state: state),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final ProcessState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    switch (state.status) {
      case ProcessStatus.fetching:
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Loading tasks...'),
              SizedBox(height: 16),
              CircularProgressIndicator(),
            ],
          ),
        );
      case ProcessStatus.fetchFailed:
        return Center(
          child: Text(
            state.errorMessage ?? 'Failed to load tasks',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(color: Colors.red),
          ),
        );
      case ProcessStatus.calculating:
      case ProcessStatus.ready:
      case ProcessStatus.sending:
      case ProcessStatus.sendFailed:
      case ProcessStatus.sent:
        final finished = state.status != ProcessStatus.calculating;
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                finished
                    ? 'All calculations has finished, you can send your results to server'
                    : 'Calculating...',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge,
              ),
              const Divider(height: 24),
              Text('${state.progress}%', style: textTheme.titleLarge),
              const Divider(height: 24),
              const SizedBox(height: 16),
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: state.progress / 100,
                  strokeWidth: 3,
                ),
              ),
              if (state.status == ProcessStatus.sendFailed) ...[
                const SizedBox(height: 24),
                Text(
                  state.errorMessage ?? 'Failed to send results',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(color: Colors.red),
                ),
              ],
            ],
          ),
        );
    }
  }
}

class _BottomAction extends StatelessWidget {
  const _BottomAction({required this.state});

  final ProcessState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProcessBloc>();

    switch (state.status) {
      case ProcessStatus.fetching:
      case ProcessStatus.calculating:
        return const SizedBox(height: 48);
      case ProcessStatus.fetchFailed:
        return PrimaryButton(label: 'Retry', onPressed: () => bloc.add(const ProcessEvent.started()));
      case ProcessStatus.ready:
      case ProcessStatus.sendFailed:
      case ProcessStatus.sent:
      case ProcessStatus.sending:
        return PrimaryButton(
          label: 'Send results to server',
          isLoading: state.status == ProcessStatus.sending,
          onPressed: () => bloc.add(const ProcessEvent.sendClicked()),
        );
    }
  }
}
