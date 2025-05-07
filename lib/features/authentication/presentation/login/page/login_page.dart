import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_app/core/getit/getit_instance.dart';
import 'package:flutter_web_app/core/presentation/button/custom_button.dart';
import 'package:flutter_web_app/core/presentation/custom_constrained_box.dart';
import 'package:flutter_web_app/core/presentation/form_field/custom_text_field.dart';
import 'package:flutter_web_app/core/presentation/layout_break_builder.dart';
import 'package:flutter_web_app/core/routes/routes.dart';
import 'package:flutter_web_app/core/validators/input_validators.dart';
import 'package:flutter_web_app/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:flutter_web_app/features/authentication/presentation/login/cubit/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginCubit = getIt.get<LoginCubit>();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailFocusNode.requestFocus();
  }

  void _onLoginButtonPressed() {
    if (formKey.currentState?.validate() ?? false) {
      loginCubit.login(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => loginCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is LoginSuccessState) {
              Navigator.pushReplacementNamed(context, Routes.home);
            }
          },
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomConstrainedBox(
                layoutSize: LayoutSize.mobile,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      CustomTextField(
                        focusNode: emailFocusNode,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        labelText: 'Your email',
                        onChanged: (value) {
                          loginCubit.enableButton(
                            email: value,
                            password: passwordController.text,
                          );
                        },
                        validator: (dynamic value) =>
                            InputValidators.validateEmail(
                          value as String,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        focusNode: passwordFocusNode,
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        labelText: 'Your password',
                        obscureText: true,
                        onChanged: (value) {
                          loginCubit.enableButton(
                            email: emailController.text,
                            password: value,
                          );
                        },
                        validator: (dynamic value) =>
                            InputValidators.validatePassword(
                          value as String,
                        ),
                      ),
                      SizedBox(height: 16),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return CustonPrimaryButton(
                            onPressed: _onLoginButtonPressed,
                            title: 'Login',
                            isLoading: state is LoginLoadingState,
                            enabled: state.buttonEnabled,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
