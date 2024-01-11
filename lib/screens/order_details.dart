import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/core/widgets/custom_appbar.dart';

import '../core/logic/cache_helper.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/map.dart';
import '../gen/assets.gen.dart';
import '../generated/locale_keys.g.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int id;

  final String fromWhere;
  const OrderDetailsScreen({
    super.key,
    required this.id,
    required this.fromWhere,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "طلب #${widget.id}"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Builder(
          builder: (BuildContext context) {
            Color color = const Color(0xffEDF5E6);
            Color statusColor = Theme.of(context).primaryColor;
            String status = "status";

            if (CacheHelper.getLanguage() == "ar") {
              switch (status) {
                case "in_way":
                case "في الطريق":
                  color = const Color(0xffEDF5E6);
                  statusColor = Theme.of(context).primaryColor;
                  status = "في الطريق";
                  break;
                case "canceled":
                case "طلب ملغي":
                  color = const Color(0xffFFE4E4);
                  statusColor = Colors.red;
                  status = "طلب ملغي";
                  break;
                case "pending":
                case "بإنتظار الموافقة":
                  color = const Color(0xffEDF5E6);
                  statusColor = Theme.of(context).primaryColor;
                  status = "بإنتظار الموافقة";
                  break;
              }
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "تفاصيل الطلب",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
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
                                "${LocaleKeys.orders_order.tr()} #id",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "date",
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
                                    color: color,
                                    borderRadius: BorderRadius.circular(7.r)),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                        color: statusColor,
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
                                image: const DecorationImage(
                                    image: NetworkImage(
                                      "https://scontent-hbe1-1.xx.fbcdn.net/v/t39.30808-6/415850344_3661430127405881_2843859566383552217_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=efb6e6&_nc_eui2=AeE4QJcZjWi5gR-m7qrgL1yw8NB-dUn-e_rw0H51Sf57-s6jDCXUEq7VbV_ONQaHtfNsiV1YTOs5TzHxL-68_990&_nc_ohc=tCN3cM8MqI0AX_vH902&_nc_ht=scontent-hbe1-1.xx&oh=00_AfCS2oGRlY4bLLb-xy4soGyw3eh8ryMS5ZbxjKkWv7uJ_w&oe=65A087AA",
                                    ),
                                    fit: BoxFit.fill)),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "عبدو شمس",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
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
                                    "الرياض",
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: 3,
                                      // itemCount: state
                                      //     .list
                                      //     .list[
                                      // index]
                                      //     .products
                                      //     .length >=
                                      //     3
                                      //     ? 3
                                      //     : state
                                      //     .list
                                      //     .list[
                                      // index]
                                      //     .products
                                      //     .length,
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
                                            image: const DecorationImage(
                                                image: NetworkImage(
                                                  "https://scontent-hbe1-1.xx.fbcdn.net/v/t39.30808-6/415850344_3661430127405881_2843859566383552217_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=efb6e6&_nc_eui2=AeE4QJcZjWi5gR-m7qrgL1yw8NB-dUn-e_rw0H51Sf57-s6jDCXUEq7VbV_ONQaHtfNsiV1YTOs5TzHxL-68_990&_nc_ohc=tCN3cM8MqI0AX_vH902&_nc_ht=scontent-hbe1-1.xx&oh=00_AfCS2oGRlY4bLLb-xy4soGyw3eh8ryMS5ZbxjKkWv7uJ_w&oe=65A087AA",
                                                ),
                                                fit: BoxFit.fill)),
                                      ),
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                  width: 4.w,
                                ),
                                // if (state
                                //     .list
                                //     .list[index]
                                //     .products
                                //     .length >
                                //     3)
                                Container(
                                  height: 25.h,
                                  width: 25.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffEDF5E6),
                                    borderRadius: BorderRadius.circular(7.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "3",
                                      // state
                                      //     .list
                                      //     .list[index]
                                      //     .products
                                      //     .length >
                                      //     3
                                      //     ? "${state.list.list[index].products.length - 3}+"
                                      //     : "0+",
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
                            "totalpcice\t${LocaleKeys.r_s.tr()}",
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Text(
                    "عنوان التوصيل",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp),
                  ),
                ),

                // if (state.list.list.address.lat != 0.0 &&
                //     state.list.list.address.lng != 0.0)
                //   Text(
                //     LocaleKeys.orders_delivery_address.tr(),
                //     style: TextStyle(
                //       color: Theme.of(context).primaryColor,
                //       fontSize: 17.sp,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // if (state.list.list.address.lat != 0.0 &&
                //     state.list.list.address.lng != 0.0)
                //   SizedBox(
                //     height: 16.h,
                //   ),
                // if (state.list.list.address.lat != 0.0 &&
                //     state.list.list.address.lng != 0.0)
                Container(
                  padding: EdgeInsets.all(8.r),
                  width: 345.w,
                  height: 85.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.02),
                          offset: const Offset(0, 6),
                          blurStyle: BlurStyle.outer,
                        ),
                      ]),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "type",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp),
                          ),
                          Text(
                            "location",
                            style: TextStyle(
                                color: const Color(0xff999797),
                                fontWeight: FontWeight.w300,
                                fontSize: 12.sp),
                          ),
                          Text(
                            "description",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 12.sp),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          getMaps(31, 32);
                        },
                        child: Container(
                          width: 75.w,
                          height: 65.h,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: MapItem(
                            lat: 31,
                            lng: 31,
                            lightMode: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  LocaleKeys.orders_order_summary.tr(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  padding: EdgeInsets.all(8.r),
                  width: 345.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffF3F8EE),
                    borderRadius: BorderRadius.circular(13.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.orders_total_products.tr(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp),
                          ),
                          Text(
                            "stringPriceBeforeDiscount\t${LocaleKeys.r_s.tr()}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.orders_discount.tr(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp),
                          ),
                          Text(
                            "stringDiscount\t${LocaleKeys.r_s.tr()}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0.r),
                        child: const Divider(
                          thickness: 2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.orders_total_after_discount.tr(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp),
                          ),
                          Text(
                            "stringOrderPrice\t${LocaleKeys.r_s.tr()}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.orders_delivery_price.tr(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp),
                          ),
                          Text(
                            "stringDeliveryPrice\t${LocaleKeys.r_s.tr()}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.orders_special_dicount.tr(),
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp),
                          ),
                          SizedBox(
                            width: 60.w,
                            child: Text(
                              "-stringVipDiscount\t${LocaleKeys.r_s.tr()}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0.r),
                        child: const Divider(
                          thickness: 2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.orders_total.tr(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp),
                          ),
                          Text(
                            "stringTotalPrice}\t${LocaleKeys.r_s.tr()}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0.r),
                        child: const Divider(
                          thickness: 2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            LocaleKeys.orders_paid_by.tr(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp),
                          ),
                          Image.asset(
                            "payType" == "cash"
                                ? Assets.icons.money.path
                                : Assets.images.visa.path,

                            // width:
                            //     state.list.list.payType == "cash" ? 70.w : 50.w,
                            // height:
                            //     state.list.list.payType == "cash" ? 30.h : 15.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar:
           widget.fromWhere == "FromHome"
              ? Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppButton(
                        text: "قبول",
                        isBig: false,
                        onPressed: () {},
                      ),
                      AppButton(
                          text: "رفض",
                          isBig: false,
                          buttonType: ButtonType.cancel,
                          onPressed: () {})
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(16.r),
                  child: AppButton(text:   widget.fromWhere == "Current"? "بدء التوصيل":"إنهاء الطلب", onPressed: () {}),
                )
          ,
    );
  }
}
