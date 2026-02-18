import 'package:flutter/material.dart';
import 'package:flutter_iot_cake_fast_app/views/cake_shop_detail_ui.dart';
import 'package:flutter_iot_cake_fast_app/views/cake_shop_list_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CakeShopListUi(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/bg_welcome.png"),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "FAKE CAST",
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900],
                ),
              ),
              Text(
                "happy kid happy cake",
                style: GoogleFonts.dancingScript(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
