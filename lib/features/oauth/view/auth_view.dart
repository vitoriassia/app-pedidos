import 'package:flutter/material.dart';
import 'package:pedidos_app/features/oauth/view/widgets/auth_form.dart';
import 'package:pedidos_app/features/oauth/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:pedidos_app/core/state/ui_state.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_verfiySession);
  }

  void _verfiySession() async {
    final result = await context.read<AuthViewModel>().checkSession();

    if (result is SuccessState<bool> && result.data) {
      _navigateToOrder();
    }
  }

  Future<void> _login({required String username, required String password}) async {
    final result = await context.read<AuthViewModel>().login(
      username: username,
      password: password,
    );
    if (result is SuccessState) {
      _navigateToOrder();
    } else if (result is FailureState) {
      _showFailureMessage(result);
    }
  }

  void _showFailureMessage(FailureState result) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(result.message), backgroundColor: Colors.red));
  }

  void _navigateToOrder() =>
      Navigator.of(context).pushNamedAndRemoveUntil('/orders', (route) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<AuthViewModel, UiState>(
        selector: (_, vm) => vm.checkSessionState,
        builder: (context, state, _) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return AuthForm(onSubmit: _login);
        },
      ),
    );
  }
}
