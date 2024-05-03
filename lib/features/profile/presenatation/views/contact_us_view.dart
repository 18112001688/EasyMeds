import 'package:flutter/material.dart';
import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/search/presentation/widgets/custom_conatct_us.dart';
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
              _launchUrl('https://www.facebook.com/');
            },
          ),
          CustomContactUsWidget(
            icon: AppImages.whatsApp,
            text: "WhatsApp",
            ontap: () {
              _launchWhatsApp('+20102994491');
            },
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

Future<void> _launchWhatsApp(String phoneNumber) async {
  String whatsappUrl = "whatsapp://send?phone=$phoneNumber";
  if (await launchUrl(Uri.parse(whatsappUrl))) {
  } else {
    throw 'Could not launch WhatsApp';
  }
}
