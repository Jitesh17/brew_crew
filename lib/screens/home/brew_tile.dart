import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  const BrewTile({required this.brew});

  @override
  Widget build(BuildContext context) {
    int brewStrength = brew.strength ;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brewStrength],
            backgroundImage: const AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
