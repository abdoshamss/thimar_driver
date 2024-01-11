import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../../core/logic/helper_methods.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../features/my_account_screens/privacy/bloc.dart';
import '../../generated/locale_keys.g.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  final _bloc = KiwiContainer().resolve<PrivacyBloc>()
    ..add(GetPrivacyDataEvent(id: 10));

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: LocaleKeys.my_account_policy.tr(),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: BlocBuilder(
              bloc: _bloc,
              builder: (BuildContext context, state) {
                if (state is PrivacyLoadingState) {
                  return loadingWidget();
                } else if (state is PrivacySuccessState) {
                  return Html(data: _bloc.data);
                } else if (state is PrivacyErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
