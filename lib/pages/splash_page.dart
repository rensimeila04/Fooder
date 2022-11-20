import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fooder/providers/menu_provider.dart';
import 'package:fooder/providers/voucher_provider.dart';
import 'package:fooder/theme.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState

    getInit();
    super.initState();
  }

  getInit() async {
    await Provider.of<MenuProvider>(
      context,
      listen: false,
    ).getMenu();
    await Provider.of<VoucherProvider>(
      context, listen: false,
    ).getVoucher();
    Navigator.pushNamed(context, '/home-page');
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/ic_splash.png',
                  ),
                ),
              ),
            ),
            Text(
              'FOODER',
              style: blueTextStyle.copyWith(
                fontSize: 32,
                fontWeight: medium,
                letterSpacing: 5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
