import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/logic/cache_helper.dart';
import '../../../core/widgets/pusher.dart';
import '../../../features/navbar_screens/components/orders_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../../order_details.dart';

class OrderItem extends StatelessWidget {
  final OrdersData model;
  final String fromWhere;
  const OrderItem({super.key, required this.model, required this.fromWhere});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(
              height: 16.h,
            ),
        itemCount: model.list.length,
        itemBuilder: (context, index) {
          final item = model.list[index];
          return  GestureDetector(
            onTap: () {
              push(
                  OrderDetailsScreen(
                    id: item.id,
                    fromWhere: fromWhere,
                  ),
                  c: context);
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
                            "${LocaleKeys.orders_order.tr()}\t#${model.list[index].id}",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            model.list[index].date,
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
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(
                                 "order_status.${model.list[index].status}".tr() ,
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
                    children: [
                      Container(
                        width: 45.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            image: DecorationImage(
                                image: NetworkImage(
                                  model.list[index].clientImage,
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
                            model.list[index].clientName,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          if (model.list[index].address.location.isNotEmpty)
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
                                Text(
                                  model.list[index].address.location,
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w300),
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
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      model.list[index].images.length >= 3
                                          ? 3
                                          : model.list[index].images.length,
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
                                              model.list[index]
                                                  .images[indexImages].url,
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                              ),
                            ]),
                            SizedBox(
                              width: 4.w,
                            ),
                            if (model.list[index].images.length > 3)
                              Container(
                                height: 25.h,
                                width: 25.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xffEDF5E6),
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                child: Center(
                                  child: Text(
                                    model.list[index].images.length > 3
                                        ? "${model.list[index].images.length - 3}+"
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
                        "${model.list[index].stringTotalPrice}\t${LocaleKeys.r_s.tr()}",
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
        });
  }
}
