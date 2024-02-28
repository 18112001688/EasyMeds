import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/auth/prsentation/widgets/custom_or_widget.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:medcs/features/home/prsentation/widgets/description_form_field.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class UploadPrescriptionView extends StatelessWidget {
  const UploadPrescriptionView({super.key});

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
      body: SingleChildScrollView(
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomUploadImage(),
            ),
            const SizedBox(
              height: 50,
            ),
            const CustomOrWidget(),
            const SizedBox(
              height: 60,
            ),
            const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Type your order',
                        style: TextStyle(
                          color: Colors.black,
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
                  onPressed: () {},
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
    );
  }
}

class CustomUploadImage extends StatefulWidget {
  const CustomUploadImage({super.key});

  @override
  State<CustomUploadImage> createState() => _CustomUploadImageState();
}

class _CustomUploadImageState extends State<CustomUploadImage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    File? _imageFile;
    final picker = ImagePicker();

    Future<void> _pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }

    Future<String?> _uploadImage(File imageFile) async {
      try {
        // Reference to the root directory of Firebase Storage
        final Reference storageRef = FirebaseStorage.instance.ref();

        // Create a reference to the file to upload
        final Reference fileRef = storageRef.child(
          'prescriptionImages/${DateTime.now().millisecondsSinceEpoch}.jpg',
        );

        // Upload the file to Firebase Storage
        final TaskSnapshot uploadTask = await fileRef.putFile(imageFile);

        // Get the download URL of the uploaded file
        final String imageUrl = await uploadTask.ref.getDownloadURL();

        // Return the download URL
        return imageUrl;
      } catch (e) {
        print('Error uploading image to Firebase Storage: $e');
        return null;
      }
    }

    return GestureDetector(
      onTap: () {
        _uploadImage(_imageFile!);
      },
      child: Container(
        width: 341,
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor, width: 0.5),
          color: themeProvider.isDarkMode
              ? AppColors.secondryScaffold
              : Colors.white,
          boxShadow: [
            BoxShadow(
              // Inner shadow
              color: themeProvider.isDarkMode
                  ? AppColors.scaffoldDarkMode
                  : const Color.fromARGB(255, 238, 238, 238),
              // Subtle grey shadow
              offset: const Offset(0.0, 1.0), // Slight offset down
              blurRadius: 4.0, // Blur radius
              spreadRadius: 2.0, // No spread
            ),
            BoxShadow(
              // Inner shadow
              color: themeProvider.isDarkMode
                  ? AppColors.scaffoldDarkMode
                  : const Color.fromARGB(255, 238, 238, 238),
              // Subtle grey shadow
              offset: const Offset(0.0, 1.0), // Slight offset down
              blurRadius: 4.0, // Blur radius
              spreadRadius: 2.0, // No spread
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 30,
                  color: AppColors.primaryColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12, left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('upload a photo of your'),
                    Text('prescription or product'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
