import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thuc_tap_flutter/services/auth/auth_service.dart';
import 'package:thuc_tap_flutter/validate/my_validate.dart';
import 'package:thuc_tap_flutter/views/resources/color.dart';
import 'package:thuc_tap_flutter/views/widgets/my_button.dart';
import 'package:thuc_tap_flutter/views/widgets/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool _showPassW = true;
  bool _isLoading = false;
  final userNameCtrl = TextEditingController();
  final passWordCtrl = TextEditingController();
  final _myValidate = MyValidate();
  final _formKey = GlobalKey<FormState>();

  void onclickShowPass() {
    if(mounted) {
      setState(() {
        _showPassW = !_showPassW;
      });
    }
  }

  void onclickSignIn() async {
    if (_formKey.currentState!.validate()) {
      if(mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      final authService = Provider.of<AuthService>(context, listen: false);
      try {
        await authService.signInWithEmailAndPassword(
          userNameCtrl.text,
          passWordCtrl.text,
        );
        // ignore: use_build_context_synchronously
        FocusScope.of(context).unfocus();
        if(mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
        if(mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      if(kDebugMode) {
        print('Validation failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Sign In to Continue!",
                      style: TextStyle(
                        color: CustomColors.themeColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    MyTextField(
                      isRightIcon: false,
                      controller: userNameCtrl,
                      hintText: "Email",
                      obscureText: false,
                      icon: const Icon(Icons.email_outlined),
                      onValidate: (value) => _myValidate.validateEmail(value),
                      textInputType: TextInputType.emailAddress,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      isRightIcon: true,
                      controller: passWordCtrl,
                      onTap: onclickShowPass,
                      hintText: "PassWord",
                      obscureText: _showPassW,
                      icon: const Icon(Icons.lock_outline),
                      onValidate: (value) => _myValidate.validatePassword(value),
                      textInputType: TextInputType.text,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    MyButton(
                      text: "SIGN IN",
                      textEnabled: "Loading...",
                      onTap: onclickSignIn,
                      sizeHeigh: double.infinity,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'New user ? ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.themeColor),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Forgot Password ?',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
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
}
