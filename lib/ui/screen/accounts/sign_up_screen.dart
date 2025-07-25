import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_guinee/services/accounts/auth.dart';
import 'package:safe_guinee/ui/screen/accounts/sign_in_screen.dart';
import 'package:safe_guinee/ui/widgets/custom_textfield.dart';
import 'package:safe_guinee/utils/app_text_style.dart';
//

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),

              Text(
                "Creez votre compte",
                style: AppTextstyles.withColor(
                  AppTextstyles.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                "S'inscrire pout commencer",
                style: AppTextstyles.withColor(
                  AppTextstyles.bodyLarge,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextfield(
                      label: "Nom Complet",
                      prefixIcon: Icons.person_2_outlined,
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your full name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextfield(
                      label: "Email",
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        } else if (!GetUtils.isEmail(value)) {
                          return "Please enter a valid Email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextfield(
                      label: "Mot de pass",
                      prefixIcon: Icons.lock_outline,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextfield(
                      label: "Confirmation de mot de pass",
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordConfirmController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the password t confirm";
                        } else if (value != _passwordController.text) {
                          return "The two password dont match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                            try {
                              await Auth().registerWithEmail(
                                _emailController.text.trim(),
                                _passwordController.text,
                              );
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }

                            _nameController.clear();
                            _passwordController.clear();
                            _passwordConfirmController.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "S'inscrire",
                          style: AppTextstyles.withColor(
                            AppTextstyles.labelMdedium,
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // signi button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ?",
                    style: AppTextstyles.withColor(
                      AppTextstyles.bodySmall,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(() => SignInScreen()),
                    child: Text(
                      "Sign in",
                      style: AppTextstyles.withColor(
                        AppTextstyles.buttonMedium,
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              // Row(
              //   children: [
              //     IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.google)),
              //     IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.google)),
              //     IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.google)),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
