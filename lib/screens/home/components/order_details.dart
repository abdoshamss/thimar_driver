import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/core/widgets/app_input.dart';
import 'package:thimar_driver/core/widgets/custom_appbar.dart';
import 'package:thimar_driver/core/widgets/pusher.dart';
import 'package:thimar_driver/features/navbar_screens/my_orders/accept_order/bloc.dart';
import 'package:thimar_driver/features/navbar_screens/my_orders/end_order/bloc.dart';
import 'package:thimar_driver/features/navbar_screens/my_orders/refuse_order/bloc.dart';
import 'package:thimar_driver/features/order_details/bloc.dart';
import 'package:thimar_driver/screens/home/view.dart';

import '../../../core/logic/cache_helper.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/map.dart';
import '../../../features/navbar_screens/my_orders/start_delivering/bloc.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int id;

  String fromWhere;

  OrderDetailsScreen({
    super.key,
    required this.id,
    required this.fromWhere,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final _bloc = KiwiContainer().resolve<OrderDetailsBloc>();
  final _acceptOrderBloc = KiwiContainer().resolve<AcceptOrderBloc>();
  final _refuseOrderBloc = KiwiContainer().resolve<RefuseOrderBloc>();
  final _startDeliveringBloc = KiwiContainer().resolve<StartDeliveringBloc>();
  final _endOrderBloc = KiwiContainer().resolve<EndOrderBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetOrderDetailsDataEvent(id: widget.id));
  }

  final _formKey = GlobalKey<FormState>();
  late double price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "طلب #${widget.id}",
        value: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            BlocBuilder(
              bloc: _bloc,
              builder: (BuildContext context, state) {
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
                    case "معلق":
                      color = const Color(0xffEDF5E6);
                      statusColor = Theme.of(context).primaryColor;
                      status = "معلق";
                      break;
                  }
                }
                if (state is OrderDetailsLoadingState) {
                  return loadingWidget();
                } else if (state is OrderDetailsSuccessState) {
                  final order = state.data.order;
                  price = order.totalPrice!;
                  status = order.status;
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
                                      "${LocaleKeys.orders_order.tr()}\t#${order.id}",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      order.date,
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
                                          borderRadius:
                                              BorderRadius.circular(7.r)),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: Text(
                                            "order_status.${order.status}".tr(),
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                            order.clientImage,
                                          ),
                                          fit: BoxFit.fill)),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.clientName,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    if (order.address.location.isNotEmpty)
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
                                              order.address.location,
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Theme.of(context)
                                                      .hintColor,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        SizedBox(
                                          width: 85.w,
                                          height: 25.h,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: order.images.length >= 3
                                                ? 3
                                                : order.images.length,
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                              width: 4.w,
                                            ),
                                            itemBuilder:
                                                (context, indexImages) =>
                                                    Container(
                                              width: 25.w,
                                              height: 25.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.r),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        order
                                                            .images[indexImages]
                                                            .url,
                                                      ),
                                                      fit: BoxFit.fill)),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      if (order.images.length > 3)
                                        Container(
                                          height: 25.h,
                                          width: 25.w,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffEDF5E6),
                                            borderRadius:
                                                BorderRadius.circular(7.r),
                                          ),
                                          child: Center(
                                            child: Text(
                                              order.images.length > 3
                                                  ? "${order.images.length - 3}+"
                                                  : "0+",
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ]),
                                Text(
                                  "${order.stringTotalPrice}\t${LocaleKeys.r_s.tr()}",
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
                      if (order.address.lat != 0.0 && order.address.lng != 0.0)
                        Padding(
                          padding: EdgeInsets.only(top: 24.h),
                          child: Text(
                            LocaleKeys.orders_delivery_address.tr(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp),
                          ),
                        ),
                      if (order.address.lat != 0.0 && order.address.lng != 0.0)
                        SizedBox(
                          height: 8.h,
                        ),
                      if (order.address.lat != 0.0 && order.address.lng != 0.0)
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    order.address.type,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp),
                                  ),
                                  Text(
                                    order.address.location,
                                    style: TextStyle(
                                        color: const Color(0xff999797),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12.sp),
                                  ),
                                  Text(
                                    order.address.description,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12.sp),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  getMaps(order.address.lat, order.address.lng);
                                },
                                child: Container(
                                  width: 75.w,
                                  height: 65.h,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: MapItem(
                                    lat: order.address.lat,
                                    lng: order.address.lng,
                                    lightMode: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 24.h,
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
                        height: 8.h,
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
                                  "${order.stringOrderPrice}\t${LocaleKeys.r_s.tr()}",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 2,
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
                                  "${order.stringDeliveryPrice}\t${LocaleKeys.r_s.tr()}",
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
                                  LocaleKeys.orders_total.tr(),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp),
                                ),
                                Text(
                                  "${order.stringTotalPrice}\t${LocaleKeys.r_s.tr()}",
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
                                  width: order.payType == "cash" ? 70.w : 50.w,
                                  height: order.payType == "cash" ? 30.h : 15.h,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      if (order.status == "pending")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            BlocBuilder(
                                buildWhen: (previous, current) =>
                                    current is AcceptOrderSuccessState,
                                bloc: _acceptOrderBloc,
                                builder: (context, state) {
                                  return AppButton(
                                    isLoading: state is AcceptOrderLoadingState,
                                    text: "قبول",
                                    isBig: false,
                                    onPressed: () {
                                      _acceptOrderBloc.add(AcceptOrderEvent(
                                          id: widget.id, context: context));
                                    },
                                  );
                                }),
                            BlocConsumer(
                                bloc: _refuseOrderBloc,
                                listener: (context, state) {
                                  if (state is RefuseOrderSuccessState) {
                                    Navigator.pop(context);
                                  }
                                },
                                builder: (context, state) {
                                  return AppButton(
                                      text: "رفض",
                                      isLoading:
                                          state is RefuseOrderLoadingState,
                                      isBig: false,
                                      buttonType: ButtonType.cancel,
                                      onPressed: () {
                                        _refuseOrderBloc.add(RefuseOrderEvent(
                                            id: widget.id, context: context));
                                      });
                                })
                          ],
                        ),
                      if (order.status == "accepted")
                        BlocConsumer(
                            bloc: _startDeliveringBloc,
                            listener: (context, state) {
                              if (state is StartDeliveringSuccessState) {
                                widget.fromWhere = "End";
                                _bloc.add(
                                    GetOrderDetailsDataEvent(id: widget.id));
                                setState(() {});
                              }
                            },
                            builder: (context, state) {
                              return AppButton(
                                  text: "بدء التوصيل",
                                  onPressed: () {
                                    {
                                      _startDeliveringBloc.add(
                                          StartDeliveringEvent(
                                              id: widget.id, context: context));
                                    }
                                  });
                            }),
                      if (order.status == "in_way")
                        BlocConsumer(
                            bloc: _endOrderBloc,
                            listener: (context, state) {
                              if (state is EndOrderSuccessState) {
                                push(HomeNavBarScreen(), );
                              }
                            },
                            builder: (context, state) {
                              return AppButton(
                                  isLoading: state is EndOrderLoadingState,
                                  text: "إنهاء الطلب",
                                  onPressed: () {
                                    {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) => Container(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: SingleChildScrollView(
                                                  padding: EdgeInsets.all(16.r),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "المبلغ المستحق من العميل",
                                                        style: TextStyle(
                                                            fontSize: 20.sp,
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 12.h),
                                                        child: Text(
                                                          "$price\t${LocaleKeys.r_s.tr()}",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 24.sp),
                                                        ),
                                                      ),
                                                      Form(
                                                        key: _formKey,
                                                        child: AppInput(
                                                          controller: _endOrderBloc
                                                              .amountController,
                                                          labelText:
                                                              "اكتب المبلغ المستلم من العميل",
                                                          validator: (value) {
                                                            if (value == null) {
                                                              return "بالرجاء ادخال المبلغ المستلم من العميل";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 24.h,
                                                      ),
                                                      AppButton(
                                                        text: "تأكيد",
                                                        onPressed: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            _endOrderBloc.add(
                                                                EndOrderEvent(
                                                                    id: widget
                                                                        .id,
                                                                    context:
                                                                        context));
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    }
                                  });
                            }),
                    ],
                  );
                } else if (state is OrderDetailsErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
