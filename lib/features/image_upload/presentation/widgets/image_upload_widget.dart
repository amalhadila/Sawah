import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../pages/image_upload_page.dart';
import '../../../../core/utils/assets.dart';
import 'package:geolocator/geolocator.dart';
import '../pages/process_selected_image_page.dart';

class ImageUploadWidget extends StatefulWidget {
  final ImageUploadSource source;
  const ImageUploadWidget({super.key, required this.source});

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  Future<void> pickImage(BuildContext context) async {
    _selectedImage = await _picker.pickImage(
        source: widget.source == ImageUploadSource.camera
            ? ImageSource.camera
            : ImageSource.gallery);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ProcessImagePage(selectedImage: _selectedImage!)));
  }

  Future<Position> _determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'Location services are disabled.';
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permissions are denied';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'Location permissions are permanently denied, we cannot request permissions.';
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      // Handle errors or permission denials here
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return Future.error(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            await _determinePosition().then((value) async {
              await pickImage(context);
            });
          },
          child: Container(
            width: 150,
            height: 135,
            decoration: const BoxDecoration(
              color: Color(0xffF2F2F2),
              boxShadow: [
                BoxShadow(
                    blurRadius: 4,
                    offset: Offset(0, 5),
                    color: Color(0x40000000),
                    spreadRadius: 0,
                    blurStyle: BlurStyle.normal)
              ],
            ),
            child: Image.asset(
                widget.source == ImageUploadSource.camera
                    ? AssetsData.takePicture
                    : AssetsData.uploadFromGallery,
                width: 84,
                height: 54),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          widget.source == ImageUploadSource.camera
              ? "imageUpload.useCamera".tr()
              : "imageUpload.useGallery".tr(),
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
