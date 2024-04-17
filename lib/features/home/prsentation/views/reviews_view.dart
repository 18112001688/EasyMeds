import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';

class ReviewsView extends StatefulWidget {
  const ReviewsView({super.key});

  @override
  State<ReviewsView> createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
  double? starRating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Reviews',
          style: StylesLight.bodyLarge17,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      '245 Reviews',
                      style: StylesLight.bodyMeduim15,
                    ),
                    Row(
                      children: [
                        Text(starRating.toString()),
                        const SizedBox(
                          width: 5,
                        ),
                        Row(
                          children: _buildStarRating(),
                        )
                      ],
                    ),
                  ],
                ),
                CustomPrimaryButton(
                    label: 'Add Review',
                    onPressed: () {
                      GoRouter.of(context).push('/AddReviewView');
                    },
                    color: AppColors.secondryOrange,
                    borderRadius: 5,
                    height: 35,
                    width: 125,
                    borderColor: AppColors.secondryOrange,
                    labelColor: Colors.white,
                    fontSize: 13)
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    const Column(
                      children: [
                        Text(
                          'Moustafa mahmoud',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 45),
                          child: Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                size: 15,
                                color: AppColors.secondryLight,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                '01/12/2024',
                                style: StylesLight.bodyExtraSmallGrey11,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(starRating.toString()),
                              const Text(
                                ' rating',
                                style: StylesDark.bodyExtraSmallGrey11,
                              )
                            ],
                          ),
                          Row(
                            children: _buildStarRating(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...',
                  style: TextStyle(
                    color: AppColors.secondryLight,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStarRating() {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      stars.add(
        GestureDetector(
          onTap: () {
            setState(() {
              starRating = i.toDouble();
            });
          },
          child: Icon(
            Icons.star,
            color: i <= (starRating ?? 0) ? Colors.amber : Colors.grey,
            size: 20, // Adjust the size of the stars
          ),
        ),
      );
    }
    return stars;
  }
}
