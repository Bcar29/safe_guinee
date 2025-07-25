import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_guinee/services/accounts/auth.dart';
import 'package:safe_guinee/ui/screen/account_screen.dart';
import 'package:safe_guinee/ui/screen/signals/envoyer_signal.dart';
import 'package:safe_guinee/ui/screen/signals/liste_signal.dart';
import 'package:safe_guinee/ui/widgets/custom_bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nave guinée"), elevation: 16),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Card(
                color: Theme.of(context).primaryColor.withAlpha(100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Image.asset("assets/images/onboarding4.png"),
                    ),

                    Text(
                      'User name',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_outlined),
              title: Text('Mon compte'),
              onTap: () {
                Get.to(() => AccountScreen());
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Deconnexion'),
              onTap: () {
                Auth().signOut();
                Navigator.pop(context); // Close the drawer
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
          ],
        ),
      ),

      body: IndexedStack(
        index: _selectedIndex,
        children: [
          ListeSignal(),
          Center(child: Text("navigation")),
          NouveauSignalement(),
        ],
      ),

      bottomNavigationBar: CustomBottomNavbar(
        index: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
