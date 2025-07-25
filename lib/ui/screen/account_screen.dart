import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:safe_guinee/controllers/theme_controller.dart';
import 'package:safe_guinee/ui/screen/accounts/change_password_screen.dart';
import 'package:safe_guinee/utils/app_text_style.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [headerSection(context), contentSection(context)],
        ),
      ),
    );
  }

  Widget headerSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      shadowColor: isDark ? Colors.white : Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? Colors.blueGrey.withAlpha(100) : Colors.transparent,
        ),
      ),
      // width: MediaQuery.of(context).size.width,
      // padding: const EdgeInsets.symmetric(vertical: 20),
      color:
          isDark ? const Color.fromARGB(215, 22, 22, 22) : Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              backgroundImage: const AssetImage(
                "assets/images/onboarding4.png",
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person),
                    const SizedBox(width: 8),
                    Text(
                      "Boubacar Barry",
                      style: AppTextstyles.withColor(
                        AppTextstyles.buttonLarge,
                        isDark
                            ? Colors.blueGrey.shade100
                            : Theme.of(context).primaryColor.withAlpha(200),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email_outlined),
                    const SizedBox(width: 8),
                    Text(
                      "alfadev29@gmail.com ",
                      style: AppTextstyles.withColor(
                        AppTextstyles.bodySmall,
                        isDark
                            ? Colors.blueGrey.shade400
                            : Theme.of(context).primaryColor.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget contentSection(BuildContext context) {
    final isdark = Provider.of<ThemeController>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        ListTile(
          leading: Icon(isdark.theme ? Icons.light_mode : Icons.dark_mode),
          title: Text(
            "Theme",
            style: AppTextstyles.withColor(
              AppTextstyles.h3,
              isDark ? Colors.grey[200]! : Colors.grey[600]!,
            ),
          ),
          trailing: Switch(
            value: isdark.theme,
            onChanged: (newValue) {
              setState(() {
                isdark.changTheme();
              });
            },
          ),
        ),
        const Divider(),
        InkWell(
          onTap: () => Get.to(() => ChangePasswordScreen()),
          child: ListTile(
            leading: Icon(Icons.edit_outlined, size: 30),
            title: Text(
              "Changer le mot de pass ",
              style: AppTextstyles.withColor(
                AppTextstyles.h3,
                isDark ? Colors.grey[400]! : Colors.grey[700]!,
              ),
            ),
            subtitle: Text(
              "Changer votre mot de pass à tout moment",
              style: AppTextstyles.withColor(
                AppTextstyles.bodySmall,
                isDark ? Colors.grey[300]! : Colors.grey[400]!,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ],
    );
  }
}
