import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/core/widgets/pusher.dart';
import 'package:thimar_driver/features/auth/logout/bloc.dart';
import 'package:thimar_driver/screens/auth/login.dart';
import 'package:thimar_driver/screens/my_account_screens/about_app.dart';
import 'package:thimar_driver/screens/my_account_screens/contact_us.dart';
import 'package:thimar_driver/screens/my_account_screens/components/screen_item.dart';
import 'package:thimar_driver/screens/my_account_screens/edit_profile.dart';
import 'package:thimar_driver/screens/my_account_screens/faqs.dart';
import 'package:thimar_driver/screens/my_account_screens/give_advice.dart';
import 'package:thimar_driver/screens/my_account_screens/privacy.dart';

import '../../../core/logic/cache_helper.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final _logOutBloc = KiwiContainer().resolve<LogOutBLoc>();

  @override
  void dispose() {
    super.dispose();
    _logOutBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 220.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r)),
            image: DecorationImage(
                image: AssetImage(
                  Assets.images.drawerBackground.path,
                ),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.my_account_my_account.tr(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                height: 75.h,
                width: 75.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(CacheHelper.getImage()))),
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    CacheHelper.getFullName().isEmpty
                        ? LocaleKeys.my_account_user_name.tr()
                        : CacheHelper.getFullName(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  if (CacheHelper.getIsVip() == 1)
                    Image.asset(
                      Assets.icons.vip.path,
                      width: 30.w,
                      height: 30.h,
                    ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                CacheHelper.getPhone().isNotEmpty
                    ? "${CacheHelper.getPhone()}+"
                    : "رقم الجوال",
                style: TextStyle(
                    color: Colors.white.withOpacity(.7), fontSize: 16.sp),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        ScreenItem(
            name: LocaleKeys.my_account_personal_data.tr(),
            widget: const EditProfileScreen(),
            icon: Assets.icons.userHome.path),
        Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.r),
              border: Border.all(color: const Color(0xffF6F6F6)),
            ),
            child: Column(
              children: [
                ScreenItem(
                    name: LocaleKeys.my_account_about_app.tr(),
                    widget: const AboutAppScreen(),
                    icon: Assets.icons.info.path),
                Divider(height: .3.h),
                ScreenItem(
                    name: LocaleKeys.my_account_faqs.tr(),
                    widget: const FaqsScreen(),
                    icon: Assets.icons.question.path),
                Divider(
                  height: .3.h,
                ),
                ScreenItem(
                    name: LocaleKeys.my_account_policy.tr(),
                    widget: const PrivacyScreen(),
                    icon: Assets.icons.check.path),
                Divider(height: .3.h),
                ScreenItem(
                    name: LocaleKeys.my_account_call_us.tr(),
                    widget: const ContactUsScreen(),
                    icon: Assets.icons.call.path),
                Divider(height: .3.h),
                ScreenItem(
                    name: LocaleKeys.my_account_complaints.tr(),
                    widget: const GiveAdviceScreen(),
                    icon: Assets.icons.edit.path),
                Divider(height: .3.h),
                ScreenItem(
                  name: LocaleKeys.my_account_change_language.tr(),
                  iconData: Icons.language,
                  onTap: () {
                    String code =
                        context.locale.languageCode == "en" ? "ar" : "en";
                    context.setLocale(Locale(code));
                    CacheHelper.setLanguage(context.locale.languageCode);
                    print(CacheHelper.getLanguage());
                  },
                ),
              ],
            ),
          ),
        ),
        BlocConsumer(
          bloc: _logOutBloc,
          listener: (BuildContext context, state) async {
            if (state is LogOutSuccessState) {
             await CacheHelper.removeLoginData();
              pushAndRemoveUntil(
                const LoginScreen(),
                c: context,
              );
            }
          },
          builder: (context, state) {
            return GestureDetector(
                onTap: () {
                  _logOutBloc.add(PostLogOutDataEvent(context: context));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.r),
                      border: Border.all(color: const Color(0xffF6F6F6)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: state is LogOutLoadingState
                          ? loadingWidget()
                          : Row(
                              children: [
                                Text(
                                  CacheHelper.getToken() == null
                                      ? LocaleKeys.my_account_log_in.tr()
                                      : LocaleKeys.my_account_log_out.tr(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Image.asset(
                                  Assets.icons.logOut.path,
                                  width: 18.w,
                                  height: 18.h,
                                ),
                              ],
                            ),
                    ),
                  ),
                ));
          },
        )
      ],
    );
  }
}
