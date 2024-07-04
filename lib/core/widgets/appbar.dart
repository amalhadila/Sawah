import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/core/widgets/custom_textfield.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/core/widgets/custom_textfield.dart';
import 'package:graduation/features/home/pres/views/widget/app_filter.dart';
import 'package:graduation/features/search/data/repos/search_repo_imp.dart';
import 'package:graduation/features/search/data/repos/search_repo_imp.dart';
import 'package:graduation/features/search/presentation/manager/searh_cubit.dart';
import 'package:graduation/features/search/presentation/manager/searh_cubit_state.dart';
import 'package:graduation/features/search/presentation/views/widgets/gridsearchresult.dart';
import 'package:graduation/features/search/presentation/manager/searh_cubit_state.dart';
import 'package:graduation/features/search/presentation/views/widgets/gridsearchresult.dart';
import 'package:graduation/features/search/presentation/views/widgets/search_view_body.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key});
  String? name;
  @override
  Size get preferredSize => const Size.fromHeight(45.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: abarcolor,
      elevation: 1,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Your other widgets like search bar or title can go here
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).push('/searchpage');
          },
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
