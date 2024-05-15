import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/features/search/presentation/manager/searh_cubit.dart';
import '../../features/home/pres/views/widget/app_filter.dart';
import '../../features/search/presentation/views/widgets/gridsearchresult.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField();

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return SizedBox(
      width: MediaQuery.of(context).size.width * .6,
      height: 36,
      child: Center(
        child: TextFormField(
          controller: searchController,
          onChanged: (value) {
            log('search');
            BlocProvider.of<SearchCubit>(context)
                .fetchSearchResult(name: value);

            //  Navigator.push(context,MaterialPageRoute(builder: (context)=> SearhResultGrid()));
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 20,
              color: Colors.orange,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(child: CustomAlertDialog());
                  },
                );
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.orange,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            hintText: 'home.search'.tr(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintStyle: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 107, 99, 99),
            ),
          ),
        ),
      ),
    );
  }
}
