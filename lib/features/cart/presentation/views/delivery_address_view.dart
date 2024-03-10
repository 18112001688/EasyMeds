import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_address.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_city_field.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_country_name.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_form_field_widget.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_name_field.dart';
import 'package:medcs/features/cart/presentation/widgets/custom_phone_number.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';

class DeliveryAdressView extends StatefulWidget {
  const DeliveryAdressView({super.key});

  @override
  State<DeliveryAdressView> createState() => _DeliveryAdressViewState();
}

TextEditingController _nameController = TextEditingController();
TextEditingController _countryController = TextEditingController();
TextEditingController _cityController = TextEditingController();
TextEditingController _phoneNumberController = TextEditingController();
TextEditingController _addressController = TextEditingController();

class _DeliveryAdressViewState extends State<DeliveryAdressView> {
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
      body: SafeArea(
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
                  textFormField: CustomAddressField(
                    controller: _addressController,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                CustomPrimaryButton(
                    label: 'Save Adress',
                    onPressed: () {},
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
    );
  }
}
