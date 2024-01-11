import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/navbar_screens/home/bloc.dart';
import 'package:thimar_driver/screens/home/components/order_item.dart';

import '../../../core/logic/cache_helper.dart';
import '../../../core/widgets/app_input.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _getData(String value) {}
  Timer? timer;
  final _bloc = KiwiContainer().resolve<PendingOrdersBloc>()
    ..add(GetPendingOrdersDataEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الرئيسية"),
        leadingWidth: CacheHelper.getLanguage() == "ar" ? 90.w : 110.w,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              Assets.images.logo.path,
              width: 20.w,
              height: 20.h,
            ),
            Text(
              LocaleKeys.home_thamara_basket.tr(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (CacheHelper.getLanguage() == "ar")
              SizedBox(
                width: 15.w,
              )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
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
              controller: _bloc.searchController,
              textInputAction: TextInputAction.search,
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys.type_word_to_search.tr();
                }
                return null;
              },
              inputType: InputType.search,
              prefixIcon: Assets.icons.search.path,
              labelText: LocaleKeys.search_about_you_want.tr(),
            ),
            SizedBox(height: 16.h),
            BlocBuilder(
              bloc: _bloc,
              builder: (BuildContext context, state) {

                if (state is PendingOrdersLoadingState) {
                  return loadingWidget();
                } else if (state is PendingOrdersSuccessState) {

                  return OrderItem(model: state.data, fromWhere: "FromHome",);
                } else if (state is PendingOrdersErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return const SizedBox.shrink();

              },
            )
          ],
        ),
      ),
    );
  }
}
