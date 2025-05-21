import 'package:flutter/material.dart';
import 'package:pedidos_app/core/state/ui_state.dart';

class UiStateBuilder<T> extends StatelessWidget {
  final UiState state;
  final Widget Function()? onInitial;
  final Widget Function()? onLoading;
  final Widget Function(String message)? onFailure;
  final Widget Function(T data)? onSuccess;
  final Widget Function(BuildContext context, UiState state)? builder;
  const UiStateBuilder({
    super.key,
    required this.state,
    this.onSuccess,
    this.onInitial,
    this.onLoading,
    this.onFailure,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    if (builder != null) {
      return builder!(context, state);
    }
    if (state is InitialState) {
      return onInitial?.call() ?? const SizedBox.shrink();
    }
    if (state is LoadingState) {
      return onLoading?.call() ?? const Center(child: CircularProgressIndicator());
    }
    if (state is FailureState) {
      final message = (state as FailureState).message;
      return onFailure?.call(message) ?? Center(child: Text(message));
    }
    if (state is SuccessState<T> && onSuccess != null) {
      return onSuccess!((state as SuccessState<T>).data);
    }
    return const SizedBox.shrink();
  }
}
