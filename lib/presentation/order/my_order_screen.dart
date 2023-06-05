import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import '../../logics/order/order_cubit.dart';
import '../../logics/services/calculation.dart';
import '../../logics/services/formatter.dart';
import '../widget/gap_widget.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
      ),
      body: SafeArea(
        child: BlocBuilder<OrderCubit, OrderState>(builder: (context , state){
          if(state is OrderLoadingState && state.orders.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(state is OrderErrorState && state.orders.isEmpty) {
            return Center(
                child: Text(state.message)
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.orders.length,
            separatorBuilder: (context, index) {
              return Column(
                children: [
                  const GapWidget(),
                  Divider(color: AppColors.textLight),
                  const GapWidget(),
                ],
              );
            },
            itemBuilder: (context, index) {

              final order = state.orders[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("# - ${order.sId}", style: TextStyles.body2.copyWith(color: AppColors.textLight),),
                  Text(Formatter.formatDate(order.createdOn!), style: TextStyles.body2.copyWith(color: AppColors.accent),),
                  Text("Order Total: ${Formatter.formatPrice(Calculations.cartTotal(order.items!))}", style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),),

                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: order.items!.length,
                    itemBuilder: (context, index) {

                      final item = order.items![index];
                      final product = item.product!;

                      return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CachedNetworkImage(
                            imageUrl: product.images![0],
                          ),
                          title: Text("${product.title}"),
                          subtitle: Text("Qty: ${item.quantity}"),
                          trailing: Text(Formatter.formatPrice(product.price! * item.quantity!))
                      );

                    },
                  ),

                ],
              );

            },
          );

        },
        ),
      ),
    );
  }
}