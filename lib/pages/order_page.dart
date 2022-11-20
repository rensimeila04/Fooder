import 'package:flutter/material.dart';
import 'package:fooder/providers/menu_provider.dart';
import 'package:fooder/providers/transaction_provider.dart';
import 'package:fooder/providers/voucher_provider.dart';
import 'package:fooder/theme.dart';
import 'package:fooder/widgets/menu_card.dart';
import 'package:fooder/widgets/order_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    VoucherProvider voucherProvider = Provider.of<VoucherProvider>(context);
    MenuProvider menuProvider = Provider.of<MenuProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    double hargaAkhir =
        menuProvider.totalPrice() - voucherProvider.diskonHarga();

    Future<void> showConfirmation() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width - 2 * 30,
          // constraints: ,
          child: AlertDialog(
            backgroundColor: kWhiteColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        size: 50,
                        color: kPrimaryColor,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          'Apakah Anda yakin ingin membatalkan pesanan ini ?',
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary: kWhiteColor,
                          elevation: 0,
                          side: BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.22,
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: Center(
                            child: Text(
                              'Batal',
                              style: blueTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          int id = transactionProvider.cancel();
                          transactionProvider.cancelCheckout(id);
                          menuProvider.deleteItem();
                          menuProvider.deleteNotes();
                          voucherProvider.deleteDiskon();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home-page', (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary: kPrimaryColor,
                          elevation: 0,
                          side: BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.22,
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: Center(
                            child: Text(
                              'Yakin',
                              style: whiteTextStyle.copyWith(
                                fontWeight: bold,
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 25,
        ),
        children: menuProvider.menus
            .map(
              (menu) => OrderCard(menu),
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
                                'Tanpa Voucher',
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
                      onPressed: () => showConfirmation(),
                      child: Text('Batalkan',
                          style: whiteTextStyle.copyWith(
                              fontWeight: bold, fontSize: 14)),
                      color: kPrimaryColor,
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
      ),
    );
  }
}
