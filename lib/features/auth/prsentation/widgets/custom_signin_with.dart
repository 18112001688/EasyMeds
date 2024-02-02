import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSigninWithButton extends StatelessWidget {
  const CustomSigninWithButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.textColor,
      required this.image});

  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.072,
      width: MediaQuery.of(context).size.width * 0.91,
      child: MaterialButton(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 0.2),
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            SvgPicture.asset(image),
            const SizedBox(
              width: 50,
            ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontFamily: 'inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
