import 'package:flutter/material.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class HelpCenterView extends StatefulWidget {
  const HelpCenterView({super.key});

  @override
  State<HelpCenterView> createState() => _HelpCenterViewState();
}

class _HelpCenterViewState extends State<HelpCenterView> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Help',
          style: themeProvider.isDarkMode
              ? StylesDark.bodyLarge17White
              : StylesLight.bodyLarge17,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'We’re here to help you with anything and everything on EasyMeds',
              style: themeProvider.isDarkMode
                  ? StylesDark.titleRegualar22White
                  : StylesLight.titleRegualar22,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const HelpWidget(
              question: 'is there a return policy ?',
              answer:
                  'Yes, we offer a 30-day return policy for eligible items. Please review our terms for details.'),
          const HelpWidget(
              question: 'Can i save my favourite items for latter ?',
              answer:
                  'Absolutely! You can save your favorite items for later viewing.'),
          const HelpWidget(
            question: ' How do i contact with customer support ?',
            answer:
                'Need help? Contact our customer support team for assistance. Navigate to our "Contact Us" screen to report an issue.',
          ),
          const HelpWidget(
            question: 'What payment method are accepted ? ',
            answer:
                'We for now accept cash and We are working on adding more payment options in the future. Stay tuned!',
          )
        ],
      ),
    );
  }
}

class HelpWidget extends StatefulWidget {
  final String question;
  final String answer;

  const HelpWidget({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<HelpWidget> createState() => _HelpWidgetState();
}

class _HelpWidgetState extends State<HelpWidget> {
  bool _showAnswer = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          _showAnswer = !_showAnswer;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: themeProvider.isDarkMode
                  ? AppColors.scaffoldDarkMode
                  : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: themeProvider.isDarkMode
                      ? AppColors.secondryLight
                      : Colors.black)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.question,
                      style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : const Color(0xff5B5B5B),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8.0),
                    _showAnswer
                        ? SingleChildScrollView(
                            child: Text(
                              widget.answer,
                              style: const TextStyle(color: Colors.deepOrange),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Icon(
                _showAnswer
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.deepOrange,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
