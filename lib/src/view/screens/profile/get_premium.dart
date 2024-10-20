import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetPremium extends StatefulWidget {
  const GetPremium({super.key});

  @override
  State<GetPremium> createState() => _GetPremiumState();
}

class _GetPremiumState extends State<GetPremium> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Plans',
          style: GoogleFonts.rubik(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
