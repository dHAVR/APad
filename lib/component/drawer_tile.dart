import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final Widget leading;
  final void Function()? onTap;

  const DrawerTile({
    super.key,
    required this.title,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.dmSerifText(
              fontSize: 30,
              color: Theme.of(context).colorScheme.inversePrimary),
        ),
        leading: leading,
        onTap: onTap,
      ),
    );
  }
}
