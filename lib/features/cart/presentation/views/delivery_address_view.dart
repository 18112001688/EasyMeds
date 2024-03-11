import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/custom_warning.dart';
import 'package:medcs/core/utlity/sanck_bar.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_address.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_city_field.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_country_name.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_form_field_widget.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_name_field.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_phone_number.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DeliveryAdressView extends StatefulWidget {
  const DeliveryAdressView({
    super.key,
  });

  @override
  State<DeliveryAdressView> createState() => _DeliveryAdressViewState();
}

TextEditingController _nameController = TextEditingController();
TextEditingController _countryController = TextEditingController();
TextEditingController _cityController = TextEditingController();
TextEditingController _phoneNumberController = TextEditingController();
TextEditingController _addressController = TextEditingController();

bool _isLoading = false;
GlobalKey<FormState> _key = GlobalKey();

class _DeliveryAdressViewState extends State<DeliveryAdressView> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'Address',
          style: StylesLight.bodyLarge17SemiBold,
        ),
      ),
      body: Form(
        key: _key,
        child: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomFormFieldWidget(
                      name: 'Name',
                      textFormField: CustomNameField(
                        controller: _nameController,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomFormFieldWidget(
                          name: 'Country',
                          textFormField: CustomCountryField(
                            controller: _countryController,
                          ),
                        ),
                        CustomFormFieldWidget(
                          name: 'City',
                          textFormField: CustomCityField(
                            controller: _cityController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomFormFieldWidget(
                      name: 'Phone Number',
                      textFormField: CustomPhoneField(
                        controller: _phoneNumberController,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomFormFieldWidget(
                      name: 'Address',
                      textFormField:
                          CustomAddressField(controller: _addressController),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    CustomPrimaryButton(
                        label: 'Save Adress',
                        onPressed: () {
                          _saveAdress(context);
                        },
                        color: AppColors.primaryColor,
                        borderRadius: 15,
                        height: 50,
                        width: 266,
                        borderColor: AppColors.primaryColor,
                        labelColor: Colors.white,
                        fontSize: 16)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveAdress(BuildContext context) async {
    final user = FirebaseAuth.instance;
    if (user.currentUser == null) {
      MyAppMethods.showWarningDialouge(
          context: context,
          label: 'sign in First so that you can save your address',
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
          await FirebaseFirestore.instance.collection('UserAddress').add({
            'UserName': _nameController.text.trim(),
            'Country': _countryController.text.trim(),
            'City': _cityController.text.trim(),
            'PhoneNumber': _phoneNumberController.text.trim(),
            'Address': _addressController.text.trim()
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar.buildSnackBar(
                    message: 'your address is saved successfully',
                    color: Colors.green));
          }
          if (mounted) {
            Navigator.of(context).pop(_addressController.text.trim());
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
