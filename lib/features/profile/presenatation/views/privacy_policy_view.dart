import 'package:flutter/material.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Privacy Policy',
          style: themeProvider.isDarkMode
              ? StylesDark.bodyLarge17White
              : StylesLight.bodyLarge17,
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Terms & Conditions',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CustomListTile(
              title: 'Acceptance',
              subtitle: 'By using EasyMeds, you agree to these terms.',
            ),
            CustomListTile(
              title: 'Account',
              subtitle: 'Keep your account info safe and accurate.',
            ),
            CustomListTile(
              title: 'Responsibilities',
              subtitle: 'Use EasyMeds lawfully and responsibly.',
            ),
            CustomListTile(
              title: 'Orders',
              subtitle: 'Pay for products ordered, including taxes and fees.',
            ),
            CustomListTile(
              title: 'Prescriptions',
              subtitle: 'Provide valid prescriptions for certain medications.',
            ),
            CustomListTile(
              title: 'Information',
              subtitle:
                  'We provide info on medicines, but consult a professional for advice.',
            ),
            CustomListTile(
              title: 'Privacy',
              subtitle:
                  'Your data is protected. Review our Privacy Policy for details.',
            ),
            CustomListTile(
              title: 'Security',
              subtitle:
                  'We use industry-standard measures to secure your information.',
            ),
            CustomListTile(
              title: 'Liability',
              subtitle: 'EasyMeds is not liable for damages or losses.',
            ),
            CustomListTile(
              title: 'Termination',
              subtitle: 'We may terminate your account without notice.',
            ),
            CustomListTile(
              title: 'Changes',
              subtitle:
                  'We may update these terms; continued use implies acceptance.',
            ),
            CustomListTile(
              title: 'Governing Law',
              subtitle: 'These terms are governed by [Jurisdiction] laws.',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomListTile(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 14),
      ),
      dense: true,
    );
  }
}
