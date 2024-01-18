import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/navbar_screens/my_orders/current/bloc.dart';
import 'package:thimar_driver/features/navbar_screens/my_orders/finished/bloc.dart';
import 'package:thimar_driver/screens/home/components/order_item.dart';

import '../../../core/widgets/app_input.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with TickerProviderStateMixin {
  final _currentOrdersBloc = KiwiContainer().resolve<CurrentOrdersBloc>()
    ..add(GetCurrentOrdersDataEvent());
  final _finishOrdersBloc = KiwiContainer().resolve<FinishedOrdersBloc>()
    ..add(GetFinishedOrderDataEvent());

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  Timer? timer;

  void _getCurrentData(String value) {
    _currentOrdersBloc.add(GetCurrentOrdersDataEvent(value: value));
  }

  void _getFinishedData(String value) {
    _finishOrdersBloc.add(GetFinishedOrderDataEvent(value: value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("طلباتي")),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            TabBar(
                automaticIndicatorColorAdjustment: true,
                unselectedLabelColor: Theme.of(context).hintColor,
                padding: const EdgeInsets.all(10),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Theme.of(context).primaryColor,
                ),
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Text(
                      "الحالية",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "المنتهية",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ]),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: AppInput(
                          controller: _currentOrdersBloc.searchController,
                          onChanged: (value) {
                            if (timer?.isActive == true) {
                              timer?.cancel();
                            }
                            timer = Timer(const Duration(seconds: 1), () {
                              _getCurrentData(value);
                            });
                            setState(() {});
                          },
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
                      ),
                      BlocBuilder(
                        bloc: _currentOrdersBloc,
                        builder: (context, state) {
                          if (state is CurrentOrdersLoadingState) {
                            return loadingWidget();
                          } else if (state is CurrentOrdersSuccessState) {
                            return OrderItem(
                                model: state.data, fromWhere: "Current");
                          } else if (state is CurrentOrdersErrorState) {
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: AppInput(
                          controller: _finishOrdersBloc.searchController,
                          onChanged: (value) {
                            if (timer?.isActive == true) {
                              timer?.cancel();
                            }
                            timer = Timer(const Duration(seconds: 1), () {
                              _getFinishedData(value);
                            });
                            setState(() {});
                          },
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
                      ),
                      BlocBuilder(
                        bloc: _finishOrdersBloc,
                        builder: (context, state) {
                          if (state is FinishedOrdersLoadingState) {
                            return loadingWidget();
                          } else if (state is FinishedOrdersSuccessState) {
                            return OrderItem(
                                model: state.data, fromWhere: "Finished");
                          } else if (state is FinishedOrdersErrorState) {
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
              ]),
            )
          ],
        ),
      ),
    );
  }
}
