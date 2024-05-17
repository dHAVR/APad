import 'package:apad/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:apad/component/drawer_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
            child: Padding(
              padding: EdgeInsets.only(top: 30.0), // Adjust the padding value as needed
              child: Text(
                "Stay focused"+'\n'+"  with APad",
                style: GoogleFonts.kalam(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),
          DrawerTile(
            title: "Notes",
            leading: Icon(Icons.home),
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            title: "Settings",
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SettingsPage(),
              )
              );

            },
          )
        ],
      ),
    );
  }
}
