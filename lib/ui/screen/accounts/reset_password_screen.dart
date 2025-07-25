import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_guinee/ui/widgets/custom_textfield.dart';
import 'package:safe_guinee/utils/app_text_style.dart';

class ResetPasswordScreen extends StatelessWidget {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  ResetPasswordScreen({super.key});

   @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Text(
                  "Reinialiser votre mot de pass",
                  style: AppTextstyles.withColor(
                    AppTextstyles.h1,
                    Colors.indigo,
                  ),
                ),
                SizedBox(height: 10),
            
                Text(
                  "Reinialiser votre mot de pass",
                  style: AppTextstyles.withColor(
                    
                    AppTextstyles.bodySmall,
                    isDark ? Colors.grey[200]! : Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 10),

            
                Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                      CustomTextfield(
                        label: "Email",
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return "Please enter your email";
                          } else if (!GetUtils.isEmail(email)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
            
                      SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => {
                            if (_keyForm.currentState!.validate()) {
                              // Simulate sending the reset link
                              Future.delayed(Duration(seconds: 2), () {
                                showSuccesDialog(context);
                              })
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16,),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: Icon(
                            Icons.send_outlined,
                            color: Colors.grey[200],
                          ),
                          label: Text(
                            "envoyer le lien",
                            style: AppTextstyles.withColor(
                              AppTextstyles.buttonMedium,
                              Colors.grey[200]!,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSuccesDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Get.dialog(
      AlertDialog(
        title: Text("Verifier votre email", style: AppTextstyles.h2),
        content: Text(
          "Nous avons envoyé un lien de réinitialisation à l'email fourni",
          style: AppTextstyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "D'accord",
              style: AppTextstyles.withColor(
                AppTextstyles.buttonMedium,
                isDark ? Colors.grey[200]! : Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
