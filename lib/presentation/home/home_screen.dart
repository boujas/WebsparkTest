import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import '../../core/route/app_router.dart';
import '../common/primary_button.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<HomeBloc>().state.savedUrl,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onStart() {
    context.read<HomeBloc>().add(HomeEvent.startClicked(_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (prev, curr) =>
          prev.status != curr.status && curr.status == HomeStatus.readyToStart,
      listener: (context, state) {
        context.router.push(const ProcessRoute());
        context.read<HomeBloc>().add(const HomeEvent.navigationHandled());
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Home screen')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Set valid API base URL in order to continue'),
                const SizedBox(height: 24),
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.errorMessage != current.errorMessage,
                  builder: (context, state) => TextField(
                    controller: _controller,
                    keyboardType: TextInputType.url,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    onChanged: (_) => context.read<HomeBloc>().add(
                      const HomeEvent.urlChanged(),
                    ),
                    onSubmitted: (_) => _onStart(),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.compare_arrows),
                      hintText: 'https://example.com/api',
                      errorText: state.errorMessage,
                      errorMaxLines: 3,
                    ),
                  ),
                ),
                const Spacer(),
                PrimaryButton(
                  label: 'Start counting process',
                  onPressed: _onStart,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
