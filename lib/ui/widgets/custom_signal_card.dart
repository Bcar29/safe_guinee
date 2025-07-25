import 'package:flutter/material.dart';
import 'package:safe_guinee/utils/app_text_style.dart';

class CustomSignalCard extends StatelessWidget {
  const CustomSignalCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDark ? Colors.grey[850] : Colors.white,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image du problème
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/onboarding1.png", // à remplacer avec ton image
                width: size.width,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // Libellé du problème
            Text(
              "Accumulation de déchets",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),

            const SizedBox(height: 8),

            // Ligne utilisateur et temps
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                // runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 8,
                children: [
                  // Bloc utilisateur
                  Row(
                    mainAxisSize: MainAxisSize.min, // important pour le wrap
                    children: [
                      Icon(
                        Icons.person,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Flexible( 
                        child: Text(
                          "alfa barry",
                          style: AppTextstyles.withColor(
                            AppTextstyles.h2,
                            Theme.of(context).primaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  // Bloc date/heure
                  Row(
                    mainAxisSize: MainAxisSize.min, // important aussi
                    children: const [
                      Icon(Icons.access_time, size: 20, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        "il y a 3 min",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Endroit du problème
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 20,
                  color:
                      isDark
                          ? Colors.grey[200]!
                          : Theme.of(context).primaryColor,
                ),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    "Route principale, quartier 5",
                    style: AppTextstyles.withColor(
                      AppTextstyles.bodyLarge,
                      isDark
                          ? Colors.grey[200]!
                          : Theme.of(context).primaryColor,
                    ),
                    overflow:
                        TextOverflow.ellipsis, // ou ellipsis si tu veux couper
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Description
            Text(
              "Des déchets sont accumulés sur la route principale, ce qui empêche la circulation des piétons.",
              style: AppTextstyles.withColor(
                AppTextstyles.bodySmall,
                isDark ? Colors.grey[400]! : Theme.of(context).primaryColor,
              ),
            ),

            const SizedBox(height: 12),

            // Actions : Infirmer / Confirmer
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment:
                    WrapAlignment.center, // centre horizontalement les éléments
                spacing: 12,
                runSpacing: 8,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.thumb_down, color: Colors.red),
                    label: const Text(
                      "Infirmer (3)",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.thumb_up, color: Colors.green),
                    label: const Text(
                      "Confirmer (8)",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
