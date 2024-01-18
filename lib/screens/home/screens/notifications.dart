import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/navbar_screens/noifications/bloc.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _bloc=KiwiContainer().resolve<NotificationsBloc>()..add(GetNotificationsDataEvent());
  @override
  void dispose() {

    super.dispose();
    _bloc.close();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
title: const Text("الإشعارات"),
      ),
      body:BlocBuilder(
        bloc: _bloc,
        builder: (context,state) {
          if(state is NotificationsLoadingState){
            return loadingWidget();
          }else if(state is NotificationsSuccessState){
            return ListView.separated(
                padding: EdgeInsets.all(16.r),
                itemCount: state.data.data.list.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 16.h,
                ),
                itemBuilder: (context, index) {
                  final item =state.data.data.list[index];
                  return Padding(
                    padding: EdgeInsetsDirectional.only(
                      bottom: 6.h,
                      start: 10.h,
                      end: 10.w,
                      top: 11.w,
                    ),
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10.r,
                              offset: const Offset(0, 5),
                              color: const Color(0x01000000),
                              blurStyle: BlurStyle.outer,spreadRadius: 10.r
                          )
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 35.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.13),
                                  borderRadius: BorderRadius.circular(9.r)),
                              child: Padding(
                                padding: EdgeInsets.all(6.0.r),
                                child: Image.network(
                                  item.image,
                                  width: 25.w,
                                  height: 25.h,
                                  fit: BoxFit.fill,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                  const Text("404"),
                                ),
                              )),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                item.title,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  item.body,
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: const Color(0xff989898)),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  item.createdAt,
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }else if(state is NotificationsErrorState){
            return Center(
              child: Text(state.message),
            );
          }
        return const SizedBox.shrink();
        }
      ),
    );
  }
}
