import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/custom_loading.dart';
import 'package:medcs/core/utlity/custom_warning.dart';
import 'package:medcs/core/utlity/sanck_bar.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/auth/prsentation/widgets/custom_or_widget.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/widgets/custom_upload_image.dart';
import 'package:medcs/features/home/prsentation/widgets/description_form_field.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class UploadPrescriptionView extends StatefulWidget {
  const UploadPrescriptionView({super.key});

  @override
  State<UploadPrescriptionView> createState() => _UploadPrescriptionViewState();
}

class _UploadPrescriptionViewState extends State<UploadPrescriptionView> {
  File? pickedImage;
  bool _isLoading = false;
  Future<void> _uploadImage(File? imageFile) async {
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user == null) {
      MyAppMethods.showWarningDialouge(
          isError: true,
          context: context,
          label: 'Sign in so you be able to upload your prescription',
          onPressedOk: () {
            GoRouter.of(context).push('/LoginView');
          },
          onPressedCancel: () {
            GoRouter.of(context).pop();
          });
    } else {
      if (imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.buildSnackBar(
            message: 'please select an image first', color: Colors.red));
      } else {
        try {
          setState(() {
            _isLoading = true;
          });

          final String fileName =
              DateTime.now().millisecondsSinceEpoch.toString();
          final String extension = imageFile.path.split('.').last;

          final Reference firebaseStorageRef = FirebaseStorage.instance
              .ref()
              .child('prescriptionImages/$fileName.$extension');
          final UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
          await uploadTask.whenComplete(() {
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar.buildSnackBar(
                    message: 'Image uploaded successfully',
                    color: Colors.green));
          });
        } catch (e) {
          rethrow;
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themePorvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        progressIndicator: const CustomLoadingIndicator(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  'Prescriptions',
                  style: themePorvider.isDarkMode
                      ? StylesDark.titleSubHeading28white
                      : StylesLight.titleSubHeading28,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomUploadImage(
                  onImagePicked: (pickedImageF) {
                    setState(() {
                      pickedImage = pickedImageF;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const CustomOrWidget(),
              const SizedBox(
                height: 60,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Type your order',
                          style: TextStyle(
                            color: themePorvider.isDarkMode
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  Text(
                    'type here your medicine name or the product ',
                    style: StylesDark.bodySmall13,
                  ),
                  Text(
                    'name that you want to order',
                    style: StylesDark.bodySmall13,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: DescriptionFormField(
                  controller: TextEditingController(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: CustomPrimaryButton(
                    label: 'send',
                    onPressed: () {
                      if (pickedImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar.buildSnackBar(
                                message:
                                    'please provide an image. or write a prescription',
                                color: Colors.red));
                      } else {
                        _uploadImage(pickedImage);
                      }
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
    );
  }
}
