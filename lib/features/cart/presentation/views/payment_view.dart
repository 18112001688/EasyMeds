import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

String? selectedPaymentOption;

class _PaymentViewState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              GoRouter.of(context).pop();
            },
            child: const Icon(Icons.arrow_back)),
        title: const Text('Payment',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'inter',
              fontSize: 17,
            )),
      ),
      body: Column(
        children: [
          RadioListTile(
            activeColor: AppColors.secondryOrange,
            title: const Text(
              'Pay with Cash',
              style: StylesLight.bodyLarge17,
            ),
            value: 'cash',
            groupValue: selectedPaymentOption,
            onChanged: (value) {
              setState(() {
                selectedPaymentOption = value;
              });
            },
          ),
          RadioListTile(
            activeColor: AppColors.secondryOrange,
            title: const Text(
              'Pay with Payment Methods',
              style: StylesLight.bodyLarge17,
            ),
            value: 'payment_method',
            groupValue: selectedPaymentOption,
            onChanged: (value) {
              setState(() {
                selectedPaymentOption = value;
              });
            },
          ),
          if (selectedPaymentOption == 'payment_method')
            const Text(
              'not avaliable now due to sucerity reasons',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}
