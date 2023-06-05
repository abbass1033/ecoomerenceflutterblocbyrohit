import 'package:ecoomerenceflutterblocbyrohit/logics/cart_cubit/cart_cubit.dart';
import 'package:ecoomerenceflutterblocbyrohit/logics/user_cubit/user_cubit.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/home/profile_screen.dart';
import 'package:ecoomerenceflutterblocbyrohit/presentation/home/user_feed_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routes.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;

  List<Widget> screens = [
    UserFeedScreen(),
    CategoryScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {

        if(state is UserLogoutState){
          Navigator.pushReplacementNamed(context, RoutesName.splashScreen);
        }
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text("Ecommerce App"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.cartScreen);
                },
                icon: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return Badge(
                      label: Text("${state.items.length}"),
                      isLabelVisible: (state is CartLoadedState) ? true : false,
                      child: const Icon(CupertinoIcons.cart_fill),

                    );
                  },
                ))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home"
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "Categories"
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile"
            ),
          ],
        ),

        body: screens[currentIndex],
      ),
    );
  }
}