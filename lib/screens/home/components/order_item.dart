import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../../../core/widgets/app_input.dart';
import '../../../core/widgets/pusher.dart';
import '../../../features/navbar_screens/components/orders_model.dart';
import '../../../features/navbar_screens/my_orders/current/bloc.dart';
import '../../../features/navbar_screens/my_orders/finished/bloc.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'order_details.dart';

class OrderItem extends StatefulWidget {
  final OrdersData model;
  final String fromWhere;

  const OrderItem({super.key, required this.model, required this.fromWhere});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  final _currentOrdersBloc = KiwiContainer().resolve<CurrentOrdersBloc>();

  final _finishOrdersBloc = KiwiContainer().resolve<FinishedOrdersBloc>();

  @override
  void dispose() {
    super.dispose();

    _currentOrdersBloc.close();
    _finishOrdersBloc.close();
  }

  Timer? timer;

  void _getData(String value) {

    if (widget.fromWhere == "Current") {
      _currentOrdersBloc.add(GetCurrentOrdersDataEvent(value: value));
    } else if (widget.fromWhere == "Finished") { _finishOrdersBloc.add(GetFinishedOrderDataEvent(value: value));}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(
                  height: 16.h,
                ),
            itemCount: widget.model.list.length,
            itemBuilder: (context, index) {
              final item = widget.model.list[index];
              return GestureDetector(
                onTap: () {
                  push(
                      OrderDetailsScreen(
                        id: item.id,
                        fromWhere: widget.fromWhere,
                      ),
                      );
                },
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  width: 345.w,
                  height: 162.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.02),
                            blurStyle: BlurStyle.outer,
                            spreadRadius: 17.r,
                            offset: const Offset(0, 6))
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${LocaleKeys.orders_order.tr()}\t#${widget.model.list[index].id}",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item.date,
                                style: TextStyle(
                                  color: const Color(0xff9C9C9C),
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 25.h,
                                decoration: BoxDecoration(
                                    color: const Color(0xffEDF5E6),
                                    borderRadius: BorderRadius.circular(7.r)),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: Text(
                                      "order_status.${widget.model.list[index].status}"
                                          .tr(),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Divider(
                          height: .2.h,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 45.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      item.clientImage,
                                    ),
                                    fit: BoxFit.fill)),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.clientName,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              if (widget.model.list[index].address.location
                                  .isNotEmpty)
                                Row(
                                  children: [
                                    Image.asset(
                                      Assets.icons.markHome.path,
                                      height: 14.h,
                                      width: 14.w,
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    SizedBox(
                                      width: 250.w,
                                      child: Text(
                                        item.address.location,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Theme.of(context).hintColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Divider(
                          height: .2.h,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  SizedBox(
                                    width: 85.w,
                                    height: 25.h,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: item.images.length >= 3
                                          ? 3
                                          : item.images.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        width: 4.w,
                                      ),
                                      itemBuilder: (context, indexImages) =>
                                          Container(
                                        width: 25.w,
                                        height: 25.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7.r),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  item.images[indexImages].url,
                                                ),
                                                fit: BoxFit.fill)),
                                      ),
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                  width: 4.w,
                                ),
                                if (widget.model.list[index].images.length > 3)
                                  Container(
                                    height: 25.h,
                                    width: 25.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffEDF5E6),
                                      borderRadius: BorderRadius.circular(7.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.images.length > 3
                                            ? "${widget.model.list[index].images.length - 3}+"
                                            : "0+",
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                              ]),
                          Text(
                            "${widget.model.list[index].stringTotalPrice}\t${LocaleKeys.r_s.tr()}",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
