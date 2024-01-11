import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/generated/locale_keys.g.dart';

import '../../core/logic/helper_methods.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../features/my_account_screens/about_app/bloc.dart';
import '../../gen/assets.gen.dart';




class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  final _bloc = KiwiContainer().resolve<AboutAppBloc>()
    ..add(GetAboutDataEvent());
  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(

        text: LocaleKeys.my_account_about_app.tr(),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
                child: Image.asset(
              Assets.images.logo.path,
              width: 160.w,
              height: 160.h,
            )),
            BlocBuilder(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is GetAboutDetailsLoadingState) {
                  return loadingWidget();
                  }  else if (state is GetAboutDetailsSuccessState) {
                    return Html(
                      data: _bloc.data,
                    );
                  }else if (state is GetAboutDetailsErrorState) {
                    return   Center(
                      child: Text(state.message??"Failed"),
                    );
                  }
                  return const SizedBox.shrink();
                }),
          ],
        ),
      ),
    );
  }
}
