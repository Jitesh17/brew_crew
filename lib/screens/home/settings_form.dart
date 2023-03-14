import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
  ];

  String? _currentName = null;
  String? _currentSugars = null;
  int? _currentStrength = null;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    // print('user.uid');
    // print(user.uid);
    // print('DatabaseService(uid: user.uid).userData');
    // print(DatabaseService(uid: user.uid).userData);
    // print('DatabaseService(uid: user.uid).userData');
    // print(DatabaseService(uid: user.uid).userData.length);
    // print('-------------------------------------------------');
    return StreamBuilder<MyUserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          // print('name is $snapshot.data?.name');
          // print(snapshot.data);
          if (snapshot.hasData) {
            MyUserData? userData = snapshot.data;
            return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Update your brew settings.',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: userData?.name,
                      decoration: textInputDecoration,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a name' : null,
                      onChanged: (value) => setState(() {
                        setState(() => _currentName = value);
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // dropdown
                    DropdownButtonFormField(
                      value: _currentSugars ?? userData?.sugars,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugar spoons'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _currentSugars = value!);
                      },
                    ),
                    // Slider
                    Slider(
                      value:
                          (_currentStrength ?? userData?.strength)!.toDouble(),
                      activeColor: Colors
                          .brown[_currentStrength ?? userData?.strength as int],
                      inactiveColor: Colors.brown[100],
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: ((value) =>
                          setState(() => _currentStrength = value.round())),
                    ),
                    ElevatedButton(
                        // color:Colors.pink,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentSugars ?? userData!.sugars!,
                                _currentName ?? userData!.name!,
                                _currentStrength ?? userData!.strength!);
                          }
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          // print(_currentName);
                          // print(_currentStrength);
                          // print(_currentSugars);
                          // DatabaseService(uid: user.uid).updateUserData(_currentSugars!, _currentName!, _currentStrength!);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pink),
                          // textStyle: MaterialStateProperty.all(
                          //     TextStyle(color: Colors.white))
                        ),
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ));
          } else {
            return Loading();
          }
        });
  }
}
