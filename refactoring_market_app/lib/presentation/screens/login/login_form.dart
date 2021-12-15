import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/home_screen.dart';
import '../../../logic/blocs/auth_bloc/auth_bloc.dart';
import '../../widgets/default_text_form_field.dart';
import '../forget_password/forget_password_screen.dart';
import '../../widgets/adaptive/adaptive_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool remember = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    BlocProvider.of<AuthBloc>(context).add(AuthUsingEmailAndPassword(
        emailController!.text, passwordController!.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                DefaultTextFormField(
                  textFieldLabel: "Email",
                  hintTextField: "Please Enter Your Email",
                  prefixIcon: const Icon(Icons.mail_outline),
                  controller: emailController,
                  keyboardTybe: TextInputType.emailAddress,
                  obsecureText: false,
                  validator: (value) {
                    if (value!.isEmpty) return "Please Enter Your Email";
                    return "";
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                DefaultTextFormField(
                  textFieldLabel: "Password",
                  hintTextField: "Please Enter Your Password",
                  prefixIcon: const Icon(Icons.lock),
                  controller: passwordController,
                  keyboardTybe: TextInputType.visiblePassword,
                  obsecureText: true,
                  suffixIcon: const Icon(Icons.remove_red_eye),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Password";
                    } else if (value == null || value.length < 8) {
                      return 'Password is too short!';
                    }
                    return "";
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, ForgetPasswordScreen.routeName),
                      child: const Text(
                        "Forget Your Password?",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.cyan,
                            fontSize: 15),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Remember Me",
                      style: TextStyle(fontSize: 15),
                    ),
                    Checkbox(
                      activeColor: const Color.fromRGBO(51, 228, 232, 1),
                      value: remember,
                      onChanged: (value) {
                        setState(() {
                          remember = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                state is AuthLoading
                    ? const CircularProgressIndicator()
                    : AdaptiveButton(
                        textButton: "Login",
                        onPressed: _submit,
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
