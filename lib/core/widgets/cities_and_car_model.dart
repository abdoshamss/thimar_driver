import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/generated/locale_keys.g.dart';

class Menu extends StatelessWidget {
  final String? fromWhere;
  const Menu({super.key,   this.fromWhere});

  @override
  Widget build(BuildContext context) {
    List<String> cities = ["cairo", "mansora", "aga", "abdo", "Mad"];
    List<String> cars = ["bmw", "nissan", "mercedes", "oudi", "Mad"];
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(LocaleKeys.register_choose_your_city.tr()),
          Center(
            child: SizedBox(
              height: 16.h,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                   fromWhere=="Cars"? cars.length:cities.length,
                    (i) => GestureDetector(
                          onTap: () {
                            Navigator.pop(context,fromWhere=="Cars"?[cars[i],i]: [cities[i],i]);
                          },
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.1),
                              ),
                              margin: EdgeInsets.only(bottom: 16.h),
                              padding: EdgeInsets.all(16.r),
                              child: Center(child: Text(fromWhere=="Cars"?cars[i]:cities[i]))),
                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
