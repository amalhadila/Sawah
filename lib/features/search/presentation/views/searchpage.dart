import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawah/features/search/presentation/manager/searh_cubit.dart';
import 'package:sawah/features/search/presentation/views/widgets/search_view_body.dart';

import '../../../image_upload/presentation/pages/image_upload_page.dart';

class CustomSearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF4B4E89),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white), // Sets the color of the back arrow icon
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for landmark',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 38, 22, 22),
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 38, 22, 22),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    ),
                    onSubmitted: (value) async {
                      log('search');
                      await BlocProvider.of<SearchCubit>(context)
                          .fetchSearchResult(name: value);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchViewBody(
                            name: value,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    color: Color.fromARGB(255, 38, 22, 22),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImagesUploadPage(), // Push to ChatScreen when camera icon is pressed
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
