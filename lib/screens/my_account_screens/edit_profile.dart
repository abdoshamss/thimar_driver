import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/widgets/app_button.dart';
import 'package:thimar_driver/core/widgets/app_input.dart';
import 'package:thimar_driver/core/widgets/custom_appbar.dart';
import 'package:thimar_driver/features/profile/edit_profile/bloc.dart';
import 'package:thimar_driver/features/profile/get_profile/bloc.dart';
import 'package:thimar_driver/screens/home/view.dart';

import '../../core/logic/helper_methods.dart';
import '../../core/widgets/cities_and_car_model.dart';
import '../../core/widgets/pusher.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../auth/components/upload_photo.dart';
import '../auth/edit_password.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  final _getProfileBloc = KiwiContainer().resolve<GetProfileBloc>()
    ..add(GetProfileDataEvent());
  final _editProfileBloc = KiwiContainer().resolve<EditProfileBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: "البيانات الشخصية"),
      body: Column(
        children: [
          SizedBox(height: 24.h),
          BlocBuilder(
              bloc: _getProfileBloc,
              builder: (BuildContext context, state) {
                if (state is GetProfileLoadingState) {
                  return loadingWidget();
                } else if (state is GetProfileSuccessState) {
                  return Column(children: [
                    GestureDetector(
                        onTap: () async {
                          _editProfileBloc.userImage = await uploadPhoto(
                            context: context,
                          );
                          setState(() {});
                        },
                        child: PhotoUpload(
                          showPhoto: true,
                          imageNumber: 0,
                          text: state.data.data.fullname,
                          image: _editProfileBloc.userImage,
                        )),
                    SizedBox(height: 4.h),
                    Text(
                      "${state.data.data.phone}+",
                      style: TextStyle(
                          fontSize: 17.sp, color: Theme.of(context).hintColor),
                    ),
                  ]);
                } else if (state is GetProfileErrorState) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              }),
          SizedBox(height: 24.h),
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
                    "البيانات الشخصية",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "بيانات السيارة",
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
                padding: EdgeInsets.all(16.h),
                child: Column(
                  children: [
                    AppInput(
                        backgroundColor: true,
                        controller: _editProfileBloc.nameController,
                        labelText: "اسم المستخدم",
                        prefixIcon: Assets.icons.userHome.path,
                     ),
                    AppInput(
                        backgroundColor: true,
                        controller: _editProfileBloc.phoneController,
                        inputType: InputType.phone,
                        labelText: "رقم الجوال",
                         ),
                    Row(
                      children: [
                        AppInput(
                            controller: _editProfileBloc.cityController,
                            backgroundColor: true,
                            inputType: InputType.city,
                            prefixIcon: Assets.icons.greenFlag.path,
                            labelText: "المدينة",
                            value: _editProfileBloc.cityController.text,
                            onPressed: () {
                              _editProfileBloc.cityController.text = "";
                              setState(() {});
                            },
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                useSafeArea: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(38.r),
                                        topRight: Radius.circular(38.r))),
                                builder: (context) => const Menu(
                                  fromWhere: "Cities",
                                ),
                              ).then((value) {
                                if (value != null) {
                                  _editProfileBloc.cityId = value[0];
                                  _editProfileBloc.cityController.text =
                                      value[1];
                                  setState(() {});
                                  print(value);
                                }
                              });
                            }),
                      ],
                    ),
                    AppInput(
                        backgroundColor: true,
                        controller: _editProfileBloc.idController,
                        inputType: InputType.phone,
                        saudiIcon: false,
                        labelText: "رقم الهوية",
                        prefixIcon: Assets.icons.circleUser.path,
                        ),
                    AppInput(
                      backgroundColor: true,
                      onTap: () {
                        push(const EditPasswordScreen(), );
                      },

                      labelText: LocaleKeys.log_in_password.tr(),
                      inputType: InputType.password,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  _editProfileBloc.licenseImage =
                                      await uploadPhoto(
                                    context: context,
                                  );
                                  setState(() {});
                                },
                                child: PhotoUpload(
                                  text: "صورة رخصة القيادة",
                                  image: _editProfileBloc.licenseImage,
                                  showPhoto: true,
                                  imageNumber: 1,
                                )),
                            GestureDetector(
                                onTap: () async {
                                  _editProfileBloc.carFormImage =
                                      await uploadPhoto(context: context);
                                  setState(() {});
                                },
                                child: PhotoUpload(
                                  text: "استمارة السيارة",
                                  image: _editProfileBloc.carFormImage,
                                  showPhoto: true,
                                  imageNumber: 2,
                                )),
                            GestureDetector(
                                onTap: () async {
                                  _editProfileBloc.carInsurance =
                                      await uploadPhoto(context: context);
                                  setState(() {});
                                },
                                child: PhotoUpload(
                                  text: "تأمين السيارة",
                                  showPhoto: true,
                                  imageNumber: 3,
                                  image: _editProfileBloc.carInsurance,
                                )),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  _editProfileBloc.frontCarImage =
                                      await uploadPhoto(context: context);
                                  setState(() {});
                                },
                                child: PhotoUpload(
                                  text: "السيارة من الأمام",
                                  image: _editProfileBloc.frontCarImage,
                                  showPhoto: true,
                                  imageNumber: 4,
                                )),
                            GestureDetector(
                                onTap: () async {
                                  _editProfileBloc.behindCarImage =
                                      await uploadPhoto(context: context);
                                  setState(() {});
                                },
                                child: PhotoUpload(
                                  text: "السيارة من الخلف",
                                  showPhoto: true,
                                  imageNumber: 5,
                                  image: _editProfileBloc.behindCarImage,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    AppInput(
                      controller: _editProfileBloc.carTypeController,
                      labelText: "نوع السيارة",
                      prefixIcon: Assets.icons.car.path,

                    ),
                    AppInput(
                      controller: _editProfileBloc.carModelController,
                      labelText: "موديل السيارة",
                      prefixIcon: Assets.icons.car.path,
                      arrow: true,
                      onTap: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(38.r),
                                  topRight: Radius.circular(38.r))),
                          context: context,
                          builder: (context) => const Menu(
                            fromWhere: 'Cars',
                          ),
                        ).then((value) {
                          if (value != null) {
                            _editProfileBloc.modelId = value[0];
                            _editProfileBloc.carModelController.text = value[1];
                          }
                        });
                      },
                    ),
                    AppInput(
                      controller: _editProfileBloc.ibanNumberController,
                      prefixIcon: Assets.icons.ipan.path,
                      inputType: InputType.phone,
                      saudiIcon: false,
                      labelText: "رقم الإيبان",



                    ),
                    AppInput(
                      controller: _editProfileBloc.bankNameController,
                      labelText: "إسم البنك",
                      prefixIcon: Assets.icons.bank.path,

                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.r),
        child: BlocConsumer(
            bloc: _editProfileBloc,
            listener: (context, state) {
              if (state is EditProfileSuccessState) {
                push(HomeNavBarScreen(), );
              }
            },
            buildWhen: (previous, current) => current is EditProfileSuccessState,
            builder: (context, state) {
              return AppButton(
                isLoading: state is EditProfileLoadingState,
                text: "تعديل البيانات",
                onPressed: () {
                  _editProfileBloc.add(PostEditProfileDataEvent(context: context));
                },
              );
            }),
      ),
    );
  }
}
