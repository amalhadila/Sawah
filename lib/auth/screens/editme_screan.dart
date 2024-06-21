// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fashion_app/constents.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import '../start_component/button.dart';
// import 'navigation_bar.dart';

// class EditProfile extends StatelessWidget {
//   const EditProfile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: KPrimaryColor,
//         elevation: 0,
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios_new,
//               color: Colors.black,
//             )),
//       ),
//       backgroundColor: KPrimaryColor,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: SingleChildScrollView(
//             child:
//                 Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//               TextFormField(
//                 onChanged: (value) {
//                   if (value.isNotEmpty) {
//                     FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(nameId)
//                         .update({'name': value});
//                   }
//                 },
//                 controller: changedNameController,
//                 cursorColor: Colors.black,
//                 decoration: const InputDecoration(
//                   suffixIcon: Icon(
//                     IconlyBroken.edit,
//                     color: KHomePageColor,
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black)),
//                   hintText: 'Change your username',
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextFormField(
//                 onChanged: (value) {
//                   if (value.isNotEmpty) {
//                     FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(nameId)
//                         .update({'image': value});
//                   }
//                 },
//                 controller: changedImageController,
//                 cursorColor: Colors.black,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'You Must Enter a value';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   suffixIcon: Icon(
//                     IconlyBroken.image,
//                     color: KHomePageColor,
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black)),
//                   hintText: 'Add your new photo link',
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               buttonComponent(
//                 onPressed: () {
//                   SnackBar snackBar = const SnackBar(
//                     content: Text('Your data changed'),
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar);

//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (contex) => const NavBarPage()));
//                 },
//                 text: 'submit changes',
//               )
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }