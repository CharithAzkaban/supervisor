import 'package:flutter/material.dart';
import 'package:performer/providers/auth_provider.dart';
import 'package:performer/utils/actions.dart';
import 'package:performer/utils/consts.dart';
import 'package:performer/utils/enums.dart';
import 'package:performer/utils/methods.dart';
import 'package:performer/widgets/back.dart';
import 'package:performer/widgets/gap.dart';
import 'package:performer/widgets/primary_button.dart';
import 'package:performer/widgets/primary_text.dart';
import 'package:performer/widgets/primary_tff.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  late final AuthProvider _authProvider;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _newPasswordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

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
        appBar: AppBar(
          backgroundColor: primary,
          leading: const Back(iconColor: white),
          title: const PrimaryText(
            'Change Password',
            color: white,
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    assetImage(
                      ImageEnum.logosingle,
                      width: dWidth(context) * 0.8,
                    ),
                    const Gap(vGap: 20.0),
                    PrimaryTFF(
                      controller: _passwordController,
                      labelText: 'Current Password',
                      obscureText: true,
                      showEye: true,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Password cannot be empty!';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => _newPasswordFocus.requestFocus(),
                    ),
                    const Gap(vGap: 10.0),
                    PrimaryTFF(
                      controller: _newPasswordController,
                      focusNode: _newPasswordFocus,
                      labelText: 'New Password',
                      obscureText: true,
                      showEye: true,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'New password cannot be empty!';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) =>
                          _confirmPasswordFocus.requestFocus(),
                    ),
                    const Gap(vGap: 10.0),
                    PrimaryTFF(
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocus,
                      labelText: 'Confirm Password',
                      obscureText: true,
                      showEye: true,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Confirm password cannot be empty!';
                        }
                        if (_newPasswordController.text != text) {
                          return 'Passwords are not matched!';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        if (_formKey.currentState!.validate()) {
                          _authProvider.resetPassword(
                            context,
                            oldPassword: _passwordController.text,
                            newPassword: _newPasswordController.text,
                          );
                        }
                      },
                    ),
                    const Gap(vGap: 10.0),
                    PrimaryButton(
                      width: inf,
                      waitingLabel: 'Changing...',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _authProvider.resetPassword(
                            context,
                            oldPassword: _passwordController.text,
                            newPassword: _newPasswordController.text,
                          );
                        }
                      },
                      label: 'CHANGE',
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
    _passwordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
