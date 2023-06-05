import 'package:ecoomerenceflutterblocbyrohit/logics/cart_cubit/cart_cubit.dart';
import 'package:ecoomerenceflutterblocbyrohit/logics/order/order_cubit.dart';
import 'package:ecoomerenceflutterblocbyrohit/logics/user_cubit/user_cubit.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/order/providers/order_detail_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../core/colors.dart';
import '../../core/routes.dart';
import '../../data/model/user/userModel.dart';
import '../widget/cart_listView.dart';
import '../widget/gap_widget.dart';
import '../widget/link_button.dart';
import '../widget/primary_button.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Order"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {


              if(state is UserLoadingState){
                return Center(child: CircularProgressIndicator(),);
              }

              if(state is UserLoggedInState){
               UserModel user = state.userModel;
               return Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("User Details", style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),),
                   const GapWidget(),
                   Text("${user.fullName}", style: TextStyles.heading3),
                   Text("Email: ${user.email}", style: TextStyles.body2,),
                   Text("Phone: ${user.phoneNumber}", style: TextStyles.body2,),
                   Text("Address: ${user.address}, ${user.city}, ${user.state}", style: TextStyles.body2,),
                   LinkButton(
                       onPressed: () {
                       //  Navigator.pushNamed(context, EditProfileScreen.routeName);
                       },
                       text: "Edit Profile"
                   ),
                 ],
               );
              }

              if(state is UserErrorState) {
                return Text(state.message);
              }

              return SizedBox();
            },
          ),


          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if(state is CartLoadingState && state.items.isEmpty) {
                return const CircularProgressIndicator();
              }

              if(state is CartErrorState && state.items.isEmpty) {
                return Text(state.message);
              }

              return CartListView(
                items: state.items,
                shrinkWrap: true,
                noScroll: true,
              );

            },
          ),

          Text("Payment", style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),),
          const GapWidget(),

         Consumer<OrderDetailProvider>(
           builder: (context , provider , child){
             return Column(
               children: [
                 RadioListTile(
                   value: "pay-on-delivery",
                   groupValue: provider.paymentMethod,
                   contentPadding: EdgeInsets.zero,
                   onChanged: provider.changePaymentMethod,
                   title: const Text("Pay on Delivery"),
                 ),
                 RadioListTile(
                   value: "pay-now",
                   groupValue: provider.paymentMethod,
                   contentPadding: EdgeInsets.zero,
                   onChanged: provider.changePaymentMethod,
                   title: const Text("Pay Now"),
                 ),


               ],
             );
           },
         ),
          const GapWidget(),
          PrimaryButton(
              onPressed: () async {

                bool success = await  BlocProvider.of<OrderCubit>(context).createOrder(
                    items: BlocProvider.of<CartCubit>(context).state.items,
                    paymentMethod: Provider.of<OrderDetailProvider>(context , listen: false).paymentMethod.toString());

                if(success){
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushNamed(context, RoutesName.orderPlacedScreen);
                }
              },
              text: "Place Order"
          ),
        ],
      ),
    );
  }
}
