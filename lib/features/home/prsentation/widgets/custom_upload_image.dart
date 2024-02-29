import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/features/home/prsentation/manger/them_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomUploadImage extends StatefulWidget {
  const CustomUploadImage({Key? key, required this.onImagePicked})
      : super(key: key);
  final void Function(File?) onImagePicked; // Callback function

  @override
  State<CustomUploadImage> createState() => _CustomUploadImageState();
}

class _CustomUploadImageState extends State<CustomUploadImage> {
  final picker = ImagePicker();
  File? pickedImage;

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        final filePath = pickedFile.path;
        setState(() {
          pickedImage = File(filePath);
          widget.onImagePicked(pickedImage);
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  void removeImage() {
    setState(() {
      pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.photo_library,
                          color: AppColors.primaryColor,
                        ),
                        title: const Text('Choose from gallery'),
                        onTap: () {
                          pickImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.camera_alt,
                          color: AppColors.primaryColor,
                        ),
                        title: const Text('Take a picture'),
                        onTap: () {
                          pickImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            width: 341,
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor, width: 0.5),
              color: themeProvider.isDarkMode
                  ? AppColors.scaffoldDarkMode
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: themeProvider.isDarkMode
                        ? AppColors.secondryScaffold
                        : AppColors.secondryPurple,
                    radius: 28,
                    child: pickedImage != null
                        ? ClipOval(
                            child: Image.file(
                              pickedImage!,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.camera_alt_outlined,
                            size: 30,
                            color: AppColors.primaryColor,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (pickedImage != null)
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('you can remove your image'),
                                Text('by clicking on remove icon'),
                              ],
                            ),
                          if (pickedImage == null)
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Upload a photo of your'),
                                Text('prescription or product'),
                              ],
                            ),
                        ]),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  pickedImage != null
                      ? IconButton(
                          onPressed: () {
                            removeImage();
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
