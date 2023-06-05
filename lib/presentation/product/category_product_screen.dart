import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecoomerenceflutterblocbyrohit/logics/category_product_cubit/category_product_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routes.dart';
import '../../logics/services/formatter.dart';
import '../widget/gap_widget.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({Key? key}) : super(key: key);

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  @override
  Widget build(BuildContext context) {

    final cubit = BlocProvider.of<CategoryProductCubit>(context);
    return Scaffold(

      appBar: AppBar(
        title: Text("${cubit.category.title}"),
      ),
      body: BlocBuilder<CategoryProductCubit, CategoryProductState>(
        builder: (context, state) {
          if(state is CategoryProductLoadingState && state.products?.isEmpty == true){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(state is CategoryProductErrorState && state.products?.isEmpty == true){
            return Center(child: Text(state.message.toString()),);
          }

          if(state is CategoryProductLoadedState && state.products?.isEmpty == true){
            return const Center(child: Text("No Product Found!"),);
          }

          return ListView.builder(
              itemCount: state.products?.length,
              itemBuilder: (context, index) {
                final product = state.products?[index];

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
                        imageUrl: product!.images![0],),

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
              });

        },
      ),

    );
  }
}
