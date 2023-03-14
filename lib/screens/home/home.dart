import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/screens/services/auth.dart';
import 'package:brew_crew/screens/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'brew_'  ;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: [
            FilledButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.person),
              label: const Text('Logout'),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent)),
            ),
            FilledButton.icon(
              onPressed: () async {
                _showSettingsPanel();
              },
              icon: const Icon(Icons.settings),
              label: const Text('settings'),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent)),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/coffee_bg.png'), fit: BoxFit.cover),      
          ),
          child: const BrewList()
          ),
      ),
    );
  }
}
