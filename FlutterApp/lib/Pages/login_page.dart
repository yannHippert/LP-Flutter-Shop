import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/Utilities/messenger.dart';
import 'package:flutter_sweater_shop/Widgets/loading_button.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Utilities/styles.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/redux/middleware/authenticate.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _storage = const FlutterSecureStorage();

  bool _passwordVisible = false;
  final _emailController = TextEditingController();
  String? _emailError;
  final _passwordController = TextEditingController();
  String? _passwordError;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChange() {
    String email = _emailController.text;
    setState(() {
      _emailError =
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(email)
              ? null
              : AppLocalizations.of(context)!.req_valid_email;
    });
  }

  void _onPasswordChange() {
    String password = _passwordController.text;
    setState(() {
      _passwordError =
          password.length > 2 ? null : AppLocalizations.of(context)!.req_field;
    });
  }

  void _togglePasswordVisbility() {
    setState(() => _passwordVisible = !_passwordVisible);
  }

  Future<void> _saveLoginInfo({
    required String email,
    required String password,
  }) async {
    await _storage.write(key: emailKey, value: email);
    await _storage.write(key: passwordKey, value: password);
  }

  void _handleLogin() {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    setState(() => _isLoading = true);

    final store = StoreProvider.of<AppState>(context);
    Completer completer = Completer();
    store.dispatch(authenticate(email, password, completer));
    completer.future
        .then((_) {
          _saveLoginInfo(email: email, password: password);
          showScaffoldMessage(
            context,
            AppLocalizations.of(context)!.user_loggedin,
          );
        })
        .catchError(_handleError)
        .whenComplete(() => setState(() => _isLoading = false));
  }

  void _handleError(Object? error, StackTrace stackTrace) {
    if (error is ApiException) {
      showScaffoldMessage(
        context,
        AppLocalizations.of(context)!.err_invalid_login,
      );
    } else {
      if (kDebugMode) print(stackTrace.toString());
    }
  }

  Widget _buildLabel(String label, String? error) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Text(error ?? "",
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ))
      ],
    );
  }

  Container _buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: cBorderRadius,
          boxShadow: const [cBoxshadow],
        ),
        height: 50.0,
        child: child);
  }

  Container _buildInput(
      {String hintText = "",
      IconData prefixIcon = Icons.abc,
      TextInputType keyboardType = TextInputType.text,
      Widget? suffixIcon,
      bool isPassword = false,
      bool obscureText = false,
      TextEditingController? controller}) {
    return _buildContainer(TextField(
      keyboardType: keyboardType,
      cursorColor: Theme.of(context).colorScheme.onPrimary,
      obscureText: obscureText,
      enableSuggestions: !isPassword,
      autocorrect: !isPassword,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 16.0),
        border: InputBorder.none,
        prefixIcon: Icon(
          prefixIcon,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
    ));
  }

  Column _buildFormField(
      {required String label, String? error, required Widget input}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildLabel(label, error),
        const SizedBox(height: 10.0),
        input
      ],
    );
  }

  Widget _buildEmailTF() {
    return _buildFormField(
        label: AppLocalizations.of(context)!.email,
        error: _emailError == null ? "" : _emailError!,
        input: _buildInput(
            hintText: AppLocalizations.of(context)!.email_placeholder,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email,
            controller: _emailController));
  }

  Widget _buildPasswordTF() {
    return _buildFormField(
        label: AppLocalizations.of(context)!.password,
        error: _passwordError == null ? "" : _passwordError!,
        input: _buildInput(
            hintText: AppLocalizations.of(context)!.password_placeholder,
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
            prefixIcon: Icons.password,
            obscureText: !_passwordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: _togglePasswordVisbility,
            ),
            controller: _passwordController));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 80.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.login,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 40.0),
            _buildEmailTF(),
            const SizedBox(height: 20.0),
            _buildPasswordTF(),
            const SizedBox(height: 40.0),
            SizedBox(
                height: 40,
                child: LoadingButton(
                    isLoading: _isLoading,
                    label: AppLocalizations.of(context)!.login,
                    onClick: _handleLogin))
          ],
        ),
      ),
    );
  }
}
