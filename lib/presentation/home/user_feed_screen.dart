import 'package:ecoomerenceflutterblocbyrohit/core/routes.dart';
import 'package:ecoomerenceflutterblocbyrohit/logics/category_cubit/category_state.dart';
import 'package:ecoomerenceflutterblocbyrohit/logics/product_cubit/product_cubit.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/product/product_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logics/services/formatter.dart';
import '../widget/gap_widget.dart';

class UserFeedScreen extends StatelessWidget {
  const UserFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {

        if(state is CategoryLoadingState && state.products.isEmpty){
          return const Center(child: CircularProgressIndicator(),);
        }

        if(state is ProductErrorState){
          return Center(child: Text(state.message.toString()),);
        }
        return Scaffold(
          body: ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];

            return CupertinoButton(
              onPressed: (){
                Navigator.pushNamed(context, RoutesName.productDetail ,arguments: product);

              },
              child: Row(
                children: [
                  CachedNetworkImage(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 3,
                    imageUrl: product.images![0],),

                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${product.title}",),
                        Text("${product.description}",),
                        const GapWidget(),
                        Text("${Formatter.formatPrice(product.price!)}",),

                      ],
                    ),
                  ),

                   IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.cart))
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
