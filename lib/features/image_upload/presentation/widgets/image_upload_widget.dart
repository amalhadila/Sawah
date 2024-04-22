import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../pages/image_upload_page.dart';
import '../../../../core/utils/assets.dart';

class ImageUploadWidget extends StatefulWidget {
  final ImageUploadSource source;
  const ImageUploadWidget({super.key, required this.source});

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  final ImagePicker _picker = ImagePicker();
  XFile ? _selectedImage;
  Future<XFile> pickImage()async{
    _selectedImage = await _picker.pickImage(source: widget.source == ImageUploadSource.camera ? ImageSource.camera : ImageSource.gallery);
    return _selectedImage!;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(onTap: ()async{
          await pickImage();
        },
          child: Container(
            width: 150,
            height: 135,
            decoration: const BoxDecoration(color: Color(0xffF2F2F2),boxShadow:const [
            BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 5),
                color: Color(0x40000000),
                spreadRadius: 0,
                blurStyle: BlurStyle.normal)
          ],),
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
