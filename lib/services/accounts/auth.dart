import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safe_guinee/controllers/is_loading_controller.dart';
import 'package:safe_guinee/ui/screen/redirection_page.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get userChanges => _firebaseAuth.userChanges();

  Future<void> registerWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        Get.snackbar(
          "Inscription reussi",
          "Votre compte a été créé avec succès",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          showProgressIndicator: true,
          isDismissible: true,
          duration: Duration(hours: 1),
        );

        Get.to(() => RedirectionPage());
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = "Le mot de passe est trop faible";
          break;
        case 'email-already-in-use':
          message = "L'email est déjà utilisé";
          break;
        case 'invalid-email':
          message = "L'email n'est pas valide";
          break;
        default:
          message = "Une erreur s'est produite. Veuillez réessayer.";
      }
      Get.snackbar(
        "Erreur",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        isDismissible: true,
        duration: Duration(hours: 1),
      );
    } catch (e) {
      Get.snackbar(
        "Erreur",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        isDismissible: true,
        duration: Duration(hours: 1),
      );
    }
  }

  Future<void> signInWithEmail(BuildContext context, String email, String password) async {
    final isLoadingController = Get.find<IsLoadingController>();

    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        Get.snackbar(
          "Connexion réussie",
          "Bienvenue ${user.email}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          isDismissible: true,
          duration: Duration(hours: 1),
        );

        Get.to(() => RedirectionPage());
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = "Aucun utilisateur trouvé pour cet email.";
          break;
        case 'wrong-password':
          message = "Mot de passe incorrect.";
          break;
        case 'invalid-email':
          message = "L'adresse email n'est pas valide.";
          break;
        case 'too-many-requests':
          message = "Trop de tentatives. Réessayez plus tard.";
          break;
        default:
          message = "Une erreur est survenue. Veuillez réessayer.";
      }
      Get.snackbar(
        "Erreur",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        isDismissible: true,
        duration: Duration(hours: 1),
      );
    } catch (e) {
      Get.snackbar(
        "Erreur catch",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        isDismissible: true,
        duration: Duration(hours: 1),
      );
    } finally {
      isLoadingController.setLoading(false);

      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final  credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

    return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      Get.snackbar(
        "Erreur",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        isDismissible: true,
        duration: Duration(hours: 1),
      );
      
    }
  }
}
