import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedidos_app/core/di/inject.dart';
import 'package:pedidos_app/core/state/ui_state.dart';
import 'package:pedidos_app/features/oauth/model/get_token_payload.dart';
import 'package:pedidos_app/features/oauth/model/repository/oauth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final OAuthRepository _repository;

  UiState _loginState = InitialState();
  UiState get loginState => _loginState;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  void _setLoginState(UiState state) {
    _loginState = state;
    notifyListeners();
  }

  void _setCheckSessionState(UiState state) {
    _checkSessionState = state;
    notifyListeners();
  }

  AuthViewModel({required OAuthRepository repository}) : _repository = repository;

  /// Attempts to log in with the given credentials.
  Future<UiState> login({required String username, required String password}) async {
    _setLoginState(LoadingState());

    GetTokenPayload payload = GetTokenPayload.password(username: username, password: password);

    final result = await _repository.login(payload: payload);

    if (result is SuccessState) {
      _isAuthenticated = true;
      addAuthInterceptor();
    }

    _setLoginState(result);
    return result;
  }

  UiState _checkSessionState = InitialState();
  UiState get checkSessionState => _checkSessionState;

  /// Checks if there is a valid access token stored.
  Future<UiState> checkSession() async {
    _setCheckSessionState(LoadingState());
    final result = await _repository.checkSession();

    if (result is SuccessState<bool> && result.data) {
      _isAuthenticated = true;
      _setCheckSessionState(result);
    }

    return result;
  }

  /// Logs out the user, clearing stored tokens.
  Future<void> logout() async {
    await _repository.logout();
    _isAuthenticated = false;
    notifyListeners();
  }
}
