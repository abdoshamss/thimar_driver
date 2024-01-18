import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/components/cities/bloc.dart';
import 'package:thimar_driver/generated/locale_keys.g.dart';

class Menu extends StatefulWidget {
  final String? fromWhere;

  const Menu({super.key, this.fromWhere});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<String> cars = ["bmw", "nissan", "mercedes", "oudi", "Mad"];
  final _citiesBloc = KiwiContainer().resolve<CitiesBloc>();

  @override
  void initState() {
    super.initState();
    _citiesBloc.add(GetCitiesDataEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _citiesBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(widget.fromWhere == "Cars"
              ? LocaleKeys.register_choose_your_city.tr()
              : "اختر موديل السيارة"),
          SizedBox(
            height: 16.h,
          ),
          BlocBuilder(
              bloc: _citiesBloc,
              builder: (context, state) {
                if (state is CitiesLoadingState) {
                  return loadingWidget();
                } else if (state is CitiesSuccessState) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            widget.fromWhere == "Cars"
                                ? cars.length
                                : state.data.data.length, (i) {
                          final city = state.data.data[i];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                  context,
                                  widget.fromWhere == "Cars"
                                      ? [cars[i], i]
                                      : [city.name, i]);
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
                                child: Center(
                                    child: Text(widget.fromWhere == "Cars"
                                        ? cars[i]
                                        : city.name))),
                          );
                        }),
                      ),
                    ),
                  );
                } else if (state is CitiesErrorState) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              }),
        ],
      ),
    );
  }
}
