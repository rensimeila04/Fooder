import 'package:flutter/material.dart';
import 'package:fooder/models/cart_model.dart';
import 'package:fooder/providers/cart_provider.dart';
import 'package:fooder/providers/menu_provider.dart';
import 'package:fooder/providers/transaction_provider.dart';
import 'package:fooder/providers/voucher_provider.dart';
import 'package:fooder/theme.dart';
import 'package:fooder/widgets/menu_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String voucherCode = "";

  @override
  Widget build(BuildContext context) {
    MenuProvider menuProvider = Provider.of<MenuProvider>(context);
    VoucherProvider voucherProvider = Provider.of<VoucherProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    double hargaAkhir = menuProvider.totalPrice() - voucherProvider.diskonHarga();
    handleCheckout() async {
      double? diskon = voucherProvider.diskonHarga();
      double totalPrice =
          menuProvider.totalPrice();
      List<CartModel> carts = cartProvider.carts;
      await transactionProvider.checkout(
        diskon!,
        totalPrice,
        carts,
      );
      Navigator.pushNamedAndRemoveUntil(context, '/order-page', (route) => false);
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 25,
        ),
        children: menuProvider.menus
            .map(
              (menu) => MenuCard(menu),
            )
            .toList(),
      );
    }

    Widget customBottomNav() {
      return Container(
        padding: EdgeInsets.only(
          top: 24,
        ),
        height: 220,
        decoration: BoxDecoration(
          color: kLightGreyColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 22,
                right: 22,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Total Pesanan',
                      style: blackTextStyle.copyWith(
                          fontSize: 18, fontWeight: semiBold),
                      children: [
                        TextSpan(
                          text: ' (${menuProvider.totalItems()} Menu):',
                          style: blackTextStyle.copyWith(
                              fontSize: 18, fontWeight: regular),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    NumberFormat.currency(
                            locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(menuProvider.totalPrice()),
                    style: blueTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: black,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 19,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 22,
                right: 22,
              ),
              child: Divider(
                thickness: 0.2,
                color: kDarkGreyColor,
              ),
            ),
            SizedBox(
              height: 19,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 22,
                right: 22,
              ),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 20,
                      ),
                      height: 212,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/ic_voucher.png',
                                height: 15,
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              Text(
                                'Punya kode voucher?',
                                style: blackTextStyle.copyWith(
                                    fontSize: 23, fontWeight: bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Masukan kode voucher disini',
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: medium,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            onSubmitted: (value) {
                              setState(() {
                                voucherProvider.saveVoucher(value);
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                voucherCode = value;
                              });
                            },
                            style: greyTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 42,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(34, 8, 8, 8)
                                      .withOpacity(0.2),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Validasi Voucher',
                                style: whiteTextStyle.copyWith(
                                    fontWeight: bold, fontSize: 16),
                              ),
                              color: kPrimaryColor,
                              textColor: kWhiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(
                                  color: Color(0xFF00717F),
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(children: [
                        Image.asset(
                          'assets/ic_voucher.png',
                          width: 22.5,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Voucher',
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        )
                      ]),
                    ),
                    voucherProvider.diskonHarga() <= 0
                        ? Container(
                            child: Row(
                              children: [
                                Text(
                                  'Input Voucher',
                                  style: greyTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: medium,
                                  ),
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/ic_arrow.png'),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      voucherProvider.getVoucherCode,
                                      style: blackTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: medium,
                                      ),
                                    ),
                                    Text(
                                      '- ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(voucherProvider.diskonHarga())}',
                                      style: redTextStyle,
                                    )
                                  ],
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/ic_arrow.png'),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 21,
            ),
            Container(
              padding: EdgeInsets.only(left: 22, right: 25, top: 14),
              height: 66,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(19, 0, 0, 0).withOpacity(0.2),
                    spreadRadius: -1,
                    blurRadius: 20,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/ic_cart.png',
                          width: 35,
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Pembayaran',
                              style: blackTextStyle.copyWith(
                                  fontSize: 12, fontWeight: medium),
                            ),
                            Text(
                              hargaAkhir <= 0
                                  ? NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp ',
                                          decimalDigits: 0)
                                      .format(0)
                                  : NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp ',
                                          decimalDigits: 0)
                                      .format(hargaAkhir),
                              style: blueTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 182 - 22,
                    height: 42,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(34, 8, 8, 8).withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: RaisedButton(
                      onPressed: menuProvider.totalItems()<= 0 ? (){}  : handleCheckout ,
                      child: Text('Pesan Sekarang',
                          style: whiteTextStyle.copyWith(
                              fontWeight: bold, fontSize: 14)),
                      color: menuProvider.totalItems() >= 1
                          ? kPrimaryColor
                          : kDarkGreyColor,
                      textColor: kWhiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(
                          color: menuProvider.totalItems() >= 1
                              ? Color(0xFF00717F)
                              : kDarkGreyColor,
                          width: 1,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    return MaterialApp(
        home: Scaffold(
      backgroundColor: kWhiteColor,
      body: content(),
      bottomNavigationBar: customBottomNav(),
    ));
  }
}
