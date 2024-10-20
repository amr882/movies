import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Help Center',
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
      body: Center(
        child: Column(
          children: [
            Text(
              'Contact Us',
              style: TextStyle(color: Colors.white, fontSize: 3.h),
            ),
            SizedBox(
              height: 10.h,
            ),
            ContactUs(
              componentText: 'WhatsApp / +201015585703',
              componentIcon: FaIcon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
                size: 3.5.h,
              ),
            ),
            ContactUs(
              componentIcon: FaIcon(
                FontAwesomeIcons.facebook,
                color: Colors.white,
                size: 3.5.h,
              ),
              componentText: 'Facebook / amr.fadel.165685',
            ),
            ContactUs(
              componentIcon: FaIcon(
                FontAwesomeIcons.instagram,
                color: Colors.white,
                size: 3.5.h,
              ),
              componentText: 'Instagram / amr.6_6',
            )
          ],
        ),
      ),
    );
  }
}

class ContactUs extends StatelessWidget {
  final Widget componentIcon;
  final String componentText;

  const ContactUs({
    super.key,
    required this.componentIcon,
    required this.componentText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.7.w),
        child: Row(
          children: [
            Row(
              children: [
                componentIcon,
                SizedBox(
                  width: 10,
                ),
                Text(
                  componentText,
                  style: GoogleFonts.rubik(
                      fontSize: 1.7.h,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
