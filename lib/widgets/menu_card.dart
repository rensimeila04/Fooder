import 'package:flutter/material.dart';
import 'package:fooder/models/menu_model.dart';
import 'package:fooder/providers/menu_provider.dart';
import 'package:fooder/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MenuCard extends StatefulWidget {
  final MenuModel menu;
  MenuCard(this.menu);

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  String notes = "";

  @override
  Widget build(BuildContext context) {
    MenuProvider menuProvider = Provider.of<MenuProvider>(context);

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: widget.menu.id == 1 ? 31 : 18, bottom: widget.menu.id == 4 ? 40 : 0),
          padding: EdgeInsets.all(
            7,
          ),
          decoration: BoxDecoration(
            color: kLightGreyColor,
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
                child: Image.network(widget.menu.gambar),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.menu.nama,
                        style: blackTextStyle.copyWith(
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
                            .format(widget.menu.harga),
                        style: blueTextStyle.copyWith(
                            fontSize: 18, fontWeight: bold),
                      ),
                      SizedBox(height: 3),
                      Row(
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
                          Container(
                            width: 100,
                            height: 14,
                            child: TextField(
                              onSubmitted: (value) {
                                setState(() {
                                  menuProvider.saveNotes(widget.menu.id,value);
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  notes = value;
                                });
                              },
                              style: blackTextStyle.copyWith(
                                  fontSize: 12, fontWeight: medium),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Tambahkan Catatan',
                                hintStyle: greyTextStyle.copyWith(
                                    fontSize: 13, fontWeight: medium),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.menu.quantity <= 0) {
                        menuProvider.menuQuantity(widget.menu.id);
                      } else {
                        menuProvider.minMenu(widget.menu.id);
                      }
                    },
                    child: Image.asset(
                      'assets/ic_min.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Text(
                    widget.menu.quantity.toString(),
                    style: blackTextStyle.copyWith(
                        fontSize: 18, fontWeight: medium),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  GestureDetector(
                    onTap: () {
                      menuProvider.addMenu(widget.menu.id);
                    },
                    child: Image.asset(
                      'assets/ic_plus.png',
                      width: 20,
                      height: 20,
                    ),
                  )
                ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
