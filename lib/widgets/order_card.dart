import 'package:flutter/material.dart';
import 'package:fooder/models/menu_model.dart';
import 'package:fooder/providers/menu_provider.dart';
import 'package:fooder/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderCard extends StatelessWidget {
  final MenuModel menu;
  OrderCard(this.menu);

  @override
  Widget build(BuildContext context) {
    MenuProvider menuProvider = Provider.of<MenuProvider>(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: menu.id == 1 ? 31 : 18,
            bottom: menu.id == 4 ? 40 : 0,
          ),
          padding: EdgeInsets.all(
            7,
          ),
          decoration: BoxDecoration(
            color: menu.quantity <= 0
                ? Color.fromARGB(162, 246, 246, 246)
                : kLightGreyColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(35, 46, 46, 46).withOpacity(0.2),
                spreadRadius: -1,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  color: kMediumGreyColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: menu.quantity <= 0
                    ? Image.network(
                        menu.gambar,
                        color: kWhiteColor.withOpacity(0.2),
                        colorBlendMode: BlendMode.modulate,
                      )
                    : Image.network(menu.gambar),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menu.nama,
                        style: menu.quantity <= 0
                            ? greyTextStyle.copyWith(
                                fontSize: 23,
                                fontWeight: medium,
                              )
                            : blackTextStyle.copyWith(
                                fontSize: 23,
                                fontWeight: medium,
                              ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        NumberFormat.currency(
                                locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                            .format(menu.harga),
                        style: menu.quantity <= 0
                            ? blueBlurTextStyle.copyWith(
                                fontSize: 18, fontWeight: bold)
                            : blueTextStyle.copyWith(
                                fontSize: 18, fontWeight: bold),
                      ),
                      SizedBox(height: 3),
                      menu.quantity <= 0
                          ? SizedBox(
                              height: 14,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 12,
                                  height: 14,
                                  child: Image.asset(
                                    'assets/ic_notes.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 7),
                                Text(menu.catatan == '' ? '' : menu.catatan, style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: medium,
                                ),)
                              ],
                            )
                    ],
                  ),
                ),
              ),
              Container(
                child: menu.quantity <= 0
                    ? SizedBox(
                        width: 50,
                      )
                    : Row(children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 36.5,
                          width: 1,
                          color: kDarkGreyColor,
                        ),
                        SizedBox(
                          width: 32,
                        ),
                        Text(
                          menu.quantity.toString(),
                          style: blueTextStyle.copyWith(
                              fontSize: 18, fontWeight: semiBold),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                      ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
