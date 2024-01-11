import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/widgets/app_input.dart';

import '../../core/logic/helper_methods.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/map.dart';
 
import '../../features/my_account_screens/contact_us/bloc.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final List<String> _icons = [
    Assets.icons.mark.path,
    Assets.icons.phoneCall.path,
    Assets.icons.message.path,
  ];

  final _getBlocData = KiwiContainer().resolve<ContactUsBloc>()
    ..add(GetContactUsDataEvent());

  final _postBlocData = KiwiContainer().resolve<ContactUsBloc>();

  @override
  void dispose() {
    super.dispose();
    _getBlocData.close();
    _postBlocData.close();
  }

  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: LocaleKeys.my_account_call_us.tr(),  ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            BlocBuilder(
                bloc: _getBlocData,
                builder: (context, state) {
                  if (state is GetContactUsDataLoadingState) {
                    return loadingWidget();
                  } else if (state is GetContactUsDataSuccessState) {
                    final List<String> titles = [
                      state.list.data.location,
                      state.list.data.phone,
                      state.list.data.email,
                    ];
                    return Column(
                      children: [
                        Stack(
                          alignment: const AlignmentDirectional(0, 1.7),
                          children: [
                            Container(
                              width: 345.w,
                              height: 200.h,clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11.r)),

                              child: MapItem(
                                lat: state.list.data.lat,
                                lng: state.list.data.lng,
                                lightMode: true,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              width: 315.w,
                              height: 90.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: Colors.white
                                  ,boxShadow: [BoxShadow(
                                  color: Colors.black.withOpacity(.02),offset: const Offset(0, 6)
                              )]
                              ),
                              child: Column(children: [
                                SizedBox(
                                  height: 16.h,
                                ),
                                ...List.generate(
                                    3,
                                        (index) => Padding(
                                      padding:
                                      EdgeInsets.only(bottom: 8.h),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            _icons[index],
                                            width: 15.w,
                                            height: 15.h,
                                          ),
                                          SizedBox(
                                            width: 8.h,
                                          ),
                                          Text(
                                            titles[index],
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight:
                                                FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                    )),
                              ]),
                            )
                          ],
                        ),
                      ],
                    );
                  } else if (state is GetContactUsDataErrorState) {
                    return   Center(child: Text(state.message));
                  }
                  return   Text( LocaleKeys.home_data_not_found.tr());
                }),
            SizedBox(
              height: 64.h,
            ),
            Text(
              LocaleKeys.contact_us_or_you_can_send_message.tr(),
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.sp),
            ),
            SizedBox(
              height: 16.h,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppInput(
                      controller: _postBlocData.nameController,
                      validator: (value) {
                        if(value!.isEmpty){
                          return LocaleKeys.register_please_enter_full_name.tr();
                        }
                        return null;
                      },
                      labelText: LocaleKeys.charge_now_name.tr(),
                    ),
                    AppInput(
                      controller: _postBlocData.phoneController,
                      validator: (value) {
                        if(value!.isEmpty){
                          return LocaleKeys.log_in_please_enter_your_mobile_number.tr();
                        }else if(value.length < 9){
                          return LocaleKeys.log_in_please_enter_nine_number.tr();
                        }
                        return null;
                      },
                      labelText: LocaleKeys.log_in_phone_number.tr(),
                      inputType: InputType.phone,
                      saudiIcon: false,
                    ),
                    AppInput(
                      controller: _postBlocData.contentController,
                      validator: (value) {
                        if(value!.isEmpty){
                          return LocaleKeys.contact_us_please_enter_content.tr();
                        }
                        return null;
                      },
                      hintText:  LocaleKeys.contact_us_subject.tr(),
                      maxLines: 5,
                    ),
                  ],
                )),
            BlocBuilder(
                bloc: _postBlocData,
                builder: (context, state) {
                  return AppButton(
                      isLoading: state is PostContactUsDataLoadingState,
                      text: LocaleKeys.contact_us_send.tr(),
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          _postBlocData.add(PostContactUsDataEvent(context: context));
                        }
                      });
                })
          ],
        ),
      ),
    );
  }
}
