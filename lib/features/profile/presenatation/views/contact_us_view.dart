import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Contact us',
          style: StylesLight.bodyLarge17,
        ),
      ),
      body: Column(
        children: [
          CustomContactUsWidget(
            icon: AppImages.facebook,
            text: "Facebook",
            ontap: () {
              _launchUrl('https://www.google.com/');
            },
          ),
          CustomContactUsWidget(
            icon: AppImages.whatsApp,
            text: "WhatsApp",
            ontap: () {},
          ),
          CustomContactUsWidget(
            icon: AppImages.twiter,
            text: "Twiter",
            ontap: () {
              _launchUrl('https://twitter.com/');
            },
          ),
          const SizedBox(
            height: 100,
          ),
          const Text(
            'or send us email via',
            style: StylesLight.bodyLarge17,
          ),
          CustomContactUsWidget(
            icon: AppImages.gmail,
            text: "Gmail",
            ontap: () {
              _launchEmail('moustafasaper167@gmail.com');
            },
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

Future<void> _launchEmail(String email) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email, // Replace with your email address
    queryParameters: {
      'subject': 'Your Subject Here', // Specify the email subject
      'body': 'Hello,\n\n', // Specify the email body (initial content)
    },
  );

  if (!await launchUrl(emailLaunchUri)) {
    throw Exception('Could not launch email');
  }
  await launchUrl(emailLaunchUri);
}

class CustomContactUsWidget extends StatelessWidget {
  const CustomContactUsWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.ontap,
  });

  final String text;
  final String icon;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 51,
          width: 304,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              SvgPicture.asset(icon),
              const SizedBox(
                width: 75,
              ),
              Text(
                text,
                style: StylesLight.bodyLarge17,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
