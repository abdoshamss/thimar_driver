import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/widgets/pusher.dart';
import 'package:thimar_driver/screens/order_details.dart';

import '../../../core/logic/cache_helper.dart';
import '../../../core/widgets/app_input.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String isSelectable =
      CacheHelper.getLanguage() == "en" ? "current" : "الحالية";
  Timer? timer;
  final searchController = TextEditingController();
  void _getData(String value) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("طلباتي")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [

            Container(
              height: 55.h,
              width: 340.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xffF3F3F3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 8.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      isSelectable = CacheHelper.getLanguage() == "en"
                          ? "current"
                          : "الحالية";

                      setState(() {});
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                      width: 160.w,
                      height: 42.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: isSelectable == "الحالية" ||
                                isSelectable == "current"
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          CacheHelper.getLanguage() == "en"
                              ? "current"
                              : "الحالية",
                          style: TextStyle(
                            color: isSelectable == "الحالية" ||
                                    isSelectable == "current"
                                ? Colors.white
                                : const Color(0xffA2A1A4),
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      isSelectable = CacheHelper.getLanguage() == "en"
                          ? "finished"
                          : "المنتهية";

                      setState(() {});
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                      width: 160.w,
                      height: 42.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: isSelectable == "المنتهية" ||
                                isSelectable == "finished"
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          CacheHelper.getLanguage() == "en"
                              ? "finished"
                              : "المنتهية",
                          style: TextStyle(
                            color: isSelectable == "المنتهية" ||
                                    isSelectable == "finished"
                                ? Colors.white
                                : const Color(0xffA2A1A4),
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            AppInput(
              onChanged: (value) {
                if (timer?.isActive == true) {
                  timer?.cancel();
                }
                timer = Timer(const Duration(seconds: 1), () {
                  _getData(value);
                });
                setState(() {});
              },
              controller: searchController,
              textInputAction: TextInputAction.search,
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys.type_word_to_search.tr();
                }
                return null;
              },
              inputType: InputType.search,
              prefixIcon: Assets.icons.search.path,
              labelText: "ابحث برقم الطلب أو اسم الشخص",
            ),


            if (isSelectable == "الحالية" ||
                isSelectable == "current")
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 7,
                separatorBuilder: (context, index) => SizedBox(
                      height: 16.h,
                    ),
                itemBuilder: (BuildContext context, int index) {
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
                      case "pending":
                      case "بإنتظار الموافقة":
                        color = const Color(0xffEDF5E6);
                        statusColor = Theme.of(context).primaryColor;
                        status = "في الطريق";
                        break;
                    }
                  }
                  return GestureDetector(
                    onTap: (){
                      push(const OrderDetailsScreen(id: 1111, fromWhere: "Current"),c: context);
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
                  );
                }),
            if (isSelectable == "المنتهية" ||
                isSelectable == "finished")
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 7,
                separatorBuilder: (context, index) => SizedBox(
                      height: 16.h,
                    ),
                itemBuilder: (BuildContext context, int index) {
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
                      case "pending":
                      case "بإنتظار الموافقة":
                        color = const Color(0xffEDF5E6);
                        statusColor = Theme.of(context).primaryColor;
                        status = "في الطريق";
                        break;
                    }
                  }
                  return GestureDetector(
                    onTap: (){
                      push(const OrderDetailsScreen(id: 1111, fromWhere: "Finished"),c: context);
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
                  );
                }),
          ],
        ),
      ),
    );
  }
}
