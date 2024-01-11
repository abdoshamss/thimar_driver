import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/widgets/app_input.dart';

import '../../core/widgets/app_button.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../features/my_account_screens/give_advice/bloc.dart';
import '../../generated/locale_keys.g.dart';

class GiveAdviceScreen extends StatefulWidget {
  const GiveAdviceScreen({super.key});

  @override
  State<GiveAdviceScreen> createState() => _GiveAdviceScreenState();
}

class _GiveAdviceScreenState extends State<GiveAdviceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bloc = KiwiContainer().resolve<GiveAdviceBloc>();

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: LocaleKeys.my_account_complaints.tr(),
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 40.h,
            ),
            children: [
              AppInput(
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.register_please_enter_full_name.tr();
                  }
                  return null;
                },
                labelText: LocaleKeys.charge_now_name.tr(),
                controller: _bloc.nameController,
              ),
              AppInput(
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.log_in_please_enter_your_mobile_number
                        .tr();
                  } else if (value.length < 9) {
                    return LocaleKeys.log_in_please_enter_nine_number.tr();
                  }
                  return null;
                },
                controller: _bloc.phoneController,
                labelText: LocaleKeys.log_in_phone_number.tr(),
                inputType: InputType.phone,
                saudiIcon: false,
              ),
              AppInput(
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.give_advice_please_enter_content_title
                        .tr();
                  }
                  return null;
                },
                controller: _bloc.titleController,
                labelText: LocaleKeys.give_advice_content_title.tr(),
              ),
              AppInput(
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.contact_us_please_enter_content.tr();
                  }
                  return null;
                },
                controller: _bloc.contentController,
                labelText: LocaleKeys.contact_us_subject.tr(),
                maxLines: 4,
              ),
              BlocBuilder(
                  bloc: _bloc,
                  builder: (context, state) {
                    return AppButton(
                      isLoading: state is GiveAdviceLoadingState,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _bloc.add(PostGiveAdviceDataEvent(context: context));
                        }
                      },
                      text: LocaleKeys.contact_us_send.tr(),
                    );
                  }),
            ],
          )),
    );
  }
}
