import 'package:flutter/material.dart';
import 'package:flutter_nodejs/common/widgets/bottom_bar.dart';
import 'package:flutter_nodejs/constants/global_variable.dart';
import 'package:flutter_nodejs/features/account/widgets/bottom_app_bar.dart';
import 'package:flutter_nodejs/features/account/widgets/orders.dart';
import 'package:flutter_nodejs/features/account/widgets/top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariable.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/equb_logo.png',
                    width: 120,
                    height: 45,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.notifications_outlined),
                      ),
                      Icon(Icons.search_outlined)
                    ],
                  ),
                )
              ],
            )),
      ),
      body: Column(
        children: const [
          BottomApp(),
          SizedBox(height: 10),
          TopButtons(),
          SizedBox(height: 10),
          Orders(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
