import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refactoring_market_app/presentation/screens/home/home_screen.dart';
import '../../widgets/adaptive/adaptive_button.dart';
import '../../widgets/default_text_form_field.dart';
import '../../../logic/blocs/auth_bloc/auth_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _emailController;
  TextEditingController? _nameController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;

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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      BlocProvider.of<AuthBloc>(context).add(RegisterUsingEmailAndPassword(
          _emailController!.text, _passwordController!.text));
    }
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
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DefaultTextFormField(
                  textFieldLabel: 'Name',
                  prefixIcon: const Icon(Icons.person),
                  obsecureText: false,
                  keyboardTybe: TextInputType.name,
                  hintTextField: 'Please enter your name',
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) return "Please enter your name";
                    return "";
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                DefaultTextFormField(
                  textFieldLabel: 'Email',
                  prefixIcon: const Icon(Icons.mail_outline),
                  obsecureText: false,
                  keyboardTybe: TextInputType.emailAddress,
                  hintTextField: 'Please enter your Email',
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) return "Please enter your Email";
                    return "";
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                DefaultTextFormField(
                  textFieldLabel: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  obsecureText: true,
                  keyboardTybe: TextInputType.visiblePassword,
                  hintTextField: 'Please Enter Your Password',
                  suffixIcon: const Icon(Icons.remove_red_eye),
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) return "Please Enter Your Password";
                    return "";
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                DefaultTextFormField(
                  textFieldLabel: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock),
                  obsecureText: true,
                  keyboardTybe: TextInputType.visiblePassword,
                  hintTextField: 'Please rewrite your password',
                  suffixIcon: const Icon(Icons.remove_red_eye),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please rewrite your password';
                    }
                    return "";
                  },
                  controller: _confirmPasswordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                state is AuthLoading
                    ? const CircularProgressIndicator()
                    : AdaptiveButton(
                        textButton: "Sign Up",
                        onPressed: _submit,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
