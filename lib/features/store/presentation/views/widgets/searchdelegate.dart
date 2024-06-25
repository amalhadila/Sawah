import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/widgets/loading_widget.dart';
import 'package:graduation/features/store/presentation/manager/cubit/searchproduct_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/searchproduct_state.dart';

class ProductSearchWidget extends StatefulWidget {
  @override
  _ProductSearchWidgetState createState() => _ProductSearchWidgetState();
}

class _ProductSearchWidgetState extends State<ProductSearchWidget> {
  String? query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search for tour...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              query = value;
            });
            BlocProvider.of<SearchproductCubit>(context).fetchSearchResult(name:query!);
          },
        ),
       
      ),
      body: BlocBuilder<SearchproductCubit, SearchproductStates>(
        builder: (context, state) {
          if (state is SearchproductSuccess) {
            final products = state.product;
            if (products.isEmpty) {
              return Center(child: Text('No results found.'));
            }
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                              onTap: () {
                                GoRouter.of(context).push('/productinfo',
                                    extra: state.product[index]);
                              },
                              child: Column(
                                children: [
                                  Container(                                   
                                            
                                                               
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 7,
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: Image.network(
                                            product.images[0],
                                            height:
                                                MediaQuery.sizeOf(context).height *
                                                    .1,
                                            width:
                                                MediaQuery.sizeOf(context).width *
                                                    .2,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  product.name ?? '',
                                                  textAlign: TextAlign.start,
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                
                                                Column(
                                                              children: [
                                  Row(
                                      children: [
                                        const Icon(
                                  Icons.location_on,
                                  color: klocicon,
                                  size: 18,
                                                              ),
                                                               
                                        Text(
                                          product.locations![0].address!,
                                          style: const TextStyle(
                                           
                                            fontSize: 13,
                                           // color: ksecondcolor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                                              ],
                                                            ),
                                  if (
                                      product.locations!.length >=2)
                                    Row(
                                      children: [
                                        const Icon(
                                  Icons.location_on,
                                  color: klocicon,
                                  size: 18,
                                                              ),
                                                               
                                        Text(
                                          product.locations![1].address!,
                                          style: const TextStyle(
                                           
                                            fontSize: 13,
                                           // color: ksecondcolor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                                              ],
                                                            ),
                                                         ] ),
                                                Text(
                                                  'price  \$${product.price}',
                                                 style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                  ),Divider(color:Color.fromARGB(255, 247, 227, 227)),
                                ],
                              ),

                            );
                          
              },
            );
          } else if (state is SearchproductFailure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
