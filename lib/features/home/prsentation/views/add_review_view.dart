import 'package:flutter/material.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/start_rating.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_name_review_field.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_review_field.dart';
import 'package:provider/provider.dart';

class AddReviewView extends StatefulWidget {
  const AddReviewView({super.key});

  @override
  State<AddReviewView> createState() => _AddReviewViewState();
}

TextEditingController _nameController = TextEditingController();
TextEditingController _reviewController = TextEditingController();

class _AddReviewViewState extends State<AddReviewView> {
  double? starRating;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Review',
          style: StylesLight.bodyLarge17,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name',
              style: StylesLight.bodyLarge17,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomNameReviewField(
              controller: _nameController,
              fillColor: themeProvider.isDarkMode
                  ? AppColors.secondryScaffold
                  : const Color(0xffF5F6FA),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'How was your experience ?',
              style: StylesLight.bodyLarge17,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomReviewFormField(
              controller: _reviewController,
              fillColor: themeProvider.isDarkMode
                  ? AppColors.secondryScaffold
                  : const Color(0xffF5F6FA),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Star',
              style: StylesLight.bodyLarge17,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StarRating(
                  starSize: 40,
                  initialRating: 0,
                  onChanged: (rating) {
                    setState(() {
                      starRating = rating;
                    });
                  },
                ),
                Text(
                  'Rating: ${starRating.toString()} ',
                  style: StylesLight.bodySmallGrey13,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
