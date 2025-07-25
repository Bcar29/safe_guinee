import 'package:flutter/material.dart';
import 'package:safe_guinee/ui/widgets/custom_textfield.dart';
import 'package:safe_guinee/utils/app_text_style.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                Text(
                  "Changer votre mot de pass",
                  style: AppTextstyles.withColor(
                    AppTextstyles.h1,
                    Colors.indigo,
                  ),
                ),
                SizedBox(height: 10),

                Text(
                  "Changer votre mot de pass",
                  style: AppTextstyles.withColor(
                    AppTextstyles.bodySmall,
                    isDark ? Colors.grey[200]! : Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 10),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextfield(
                        label: "Ancien mot de pass",
                        prefixIcon: Icons.lock_outline,
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        controller: _oldPasswordController,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Veuillez entrer votre ancien mot de pass";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      CustomTextfield(
                        label: "Nouveau mot de pass",
                        prefixIcon: Icons.lock_outline,
                        keyboardType: TextInputType.text,
                        controller: _newPasswordController,
                        isPassword: true,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Veuillez entrer votre ancien mot de pass";
                          } else if (val != _oldPasswordController.text) {
                            return "les deux mots de pass doit etre identique";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: Icon(
                            Icons.mode_edit_outline,
                            color: Colors.grey[200],
                          ),
                          label: Text(
                            "Modifier",
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

  
}
