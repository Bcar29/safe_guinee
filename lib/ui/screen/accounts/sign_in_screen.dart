import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_guinee/controllers/is_loading_controller.dart';
import 'package:safe_guinee/services/accounts/auth.dart';
import 'package:safe_guinee/ui/screen/accounts/reset_password_screen.dart';
import 'package:safe_guinee/ui/screen/accounts/sign_up_screen.dart';
import 'package:safe_guinee/ui/widgets/custom_textfield.dart';
import 'package:safe_guinee/utils/app_text_style.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final IsLoadingController isLoadingController = Get.put(
    IsLoadingController(),
  );
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: Text("connexion ")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Welcome Back !",
                style: AppTextstyles.withColor(AppTextstyles.h1, Colors.indigo),
              ),

              SizedBox(height: 8),
              Text(
                "Veuillez vous authentifié pour continuer !",
                style: AppTextstyles.withColor(
                  AppTextstyles.bodyLarge,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
              SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextfield(
                      label: "Email",
                      prefixIcon: Icons.email_outlined,
                      controller: _emailController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Veuillez entrez votre addresse email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextfield(
                      label: "Mot de Pass",
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      controller: _passwordController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Get.to(() => ResetPasswordScreen()),
                        child: Text(
                          "Mot de pass oublié ? ",
                          style: AppTextstyles.withColor(
                            AppTextstyles.buttonSmall,
                            isDark
                                ? Colors.grey[200]!
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            isLoadingController.setLoading(true);
                            if (isLoadingController.isLoadingValue) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                            }

                            await Auth().signInWithEmail(
                              context,
                              _emailController.text.trim(),
                              _passwordController.text,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: Icon(
                          Icons.login_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: Text(
                          "Se connecter",
                          style: AppTextstyles.withColor(
                            AppTextstyles.buttonMedium,
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 32, thickness: 1, color: Colors.grey),
                    ElevatedButton.icon(
                      onPressed: () {
                        Auth().signInWithGoogle();
                      },
                      label: Text(
                        "Se connecter avec Google",
                        style: AppTextstyles.withColor(
                          AppTextstyles.buttonMedium,
                          Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // signup textbutton
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Vous n'avez pas  de compte ?",
                    style: AppTextstyles.withColor(
                      AppTextstyles.bodySmall,
                      isDark
                          ? Colors.grey[200]!
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(width: 12),
                  TextButton(
                    onPressed: () => Get.to(() => SignUpScreen()),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(
                        context,
                      ).primaryColor.withAlpha(100),
                    ),

                    child: Text(
                      "S'inscrire",
                      style: AppTextstyles.withColor(
                        AppTextstyles.buttonMedium,
                        isDark
                            ? Colors.grey[400]!
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
