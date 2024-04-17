import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/custom_warning.dart';
import 'package:medcs/core/utlity/sanck_bar.dart';
import 'package:medcs/core/utlity/start_rating.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_name_review_field.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_review_field.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddReviewView extends StatefulWidget {
  const AddReviewView({super.key, required this.productID});

  final String productID;

  @override
  State<AddReviewView> createState() => _AddReviewViewState();
}

TextEditingController _nameController = TextEditingController();
TextEditingController _reviewController = TextEditingController();

bool _isLoading = false;
GlobalKey<FormState> _key = GlobalKey();

class _AddReviewViewState extends State<AddReviewView> {
  double? starRating;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Add Review',
            style: StylesLight.bodyLarge17,
          ),
        ),
        body: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Padding(
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
                        'Rating: ${starRating != null ? starRating.toString() : '0.0'}',
                        style: StylesLight.bodySmallGrey13,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: CustomPrimaryButton(
                        label: 'Submit Review',
                        onPressed: () {
                          _saveReview(context);
                        },
                        color: AppColors.primaryColor,
                        borderRadius: 15,
                        height: 50,
                        width: 266,
                        borderColor: AppColors.primaryColor,
                        labelColor: Colors.white,
                        fontSize: 16),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveReview(BuildContext context) async {
    final user = FirebaseAuth.instance;
    if (user.currentUser == null) {
      MyAppMethods.showWarningDialouge(
          context: context,
          label: 'sign in First so that you can add a review',
          onPressedOk: () {
            GoRouter.of(context).pop();
          },
          onPressedCancel: () {});
    } else {
      if (_key.currentState!.validate()) {
        try {
          setState(() {
            _isLoading = true;
          });
          // Get the current date and time
          final DateTime now = DateTime.now();
          final Timestamp reviewDate = Timestamp.fromDate(now);
          await FirebaseFirestore.instance.collection('UsersReview').add({
            'ProductID': widget.productID,
            'UserName': _nameController.text.trim(),
            'Review': _reviewController.text.trim(),
            'Rating': starRating ?? 0,
            'userImage': user.currentUser!.photoURL,
            'ReviewDate': reviewDate
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar.buildSnackBar(
                    message: 'your Review is saved successfully',
                    color: Colors.green));
          }
          if (mounted) {
            Navigator.of(context).pop();
          }
        } catch (e) {
          rethrow;
        }
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
