import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riot/utils/style.dart';
import 'pages/main_vc.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await Future.delayed(
      Duration(milliseconds: 2000),
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainVC()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundPrimaryColor,
      body: Center(
        child: Text(
          'Krates.gg',
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
