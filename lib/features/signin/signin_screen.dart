import 'package:flutter/material.dart';
import 'package:supervisor/providers/auth_provider.dart';
import 'package:supervisor/utils/actions.dart';
import 'package:supervisor/utils/consts.dart';
import 'package:supervisor/utils/enums.dart';
import 'package:supervisor/utils/methods.dart';
import 'package:supervisor/widgets/gap.dart';
import 'package:supervisor/widgets/primary_button.dart';
import 'package:supervisor/widgets/primary_tff.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocus = FocusNode();
  late final AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _authProvider = provider<AuthProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocus(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    assetImage(
                      ImageEnum.logosingle,
                      width: 150.0,
                      height: 150.0,
                    ),
                    const Gap(vGap: 20.0),
                    PrimaryTFF(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      labelText: 'Email',
                      validator: (text) => textOrEmpty(text).isEmpty
                          ? 'Email is required!'
                          : null,
                      onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
                    ),
                    const Gap(vGap: 10.0),
                    PrimaryTFF(
                      keyboardType: TextInputType.text,
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      labelText: 'Password',
                      obscureText: true,
                      showEye: true,
                      validator: (text) => textOrEmpty(text).isEmpty
                          ? 'Password is required!'
                          : null,
                      onFieldSubmitted: (_) => _authProvider.signin(
                        context,
                        formKey: _formKey,
                        email: _emailController.text.trim().toLowerCase(),
                        password: _passwordController.text,
                      ),
                    ),
                    const Gap(vGap: 20.0),
                    PrimaryButton(
                      width: inf,
                      onPressed: () => _authProvider.signin(
                        context,
                        formKey: _formKey,
                        email: _emailController.text.trim().toLowerCase(),
                        password: _passwordController.text,
                      ),
                      label: 'SIGN IN',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }
}
