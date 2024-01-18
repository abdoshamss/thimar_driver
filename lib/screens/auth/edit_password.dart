import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/widgets/app_input.dart';
import 'package:thimar_driver/core/widgets/pusher.dart';
import 'package:thimar_driver/screens/my_account_screens/edit_profile.dart';

import '../../core/widgets/app_button.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../features/auth/edit_password/bloc.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _ChangePasswordStateScreen();
}

class _ChangePasswordStateScreen extends State<EditPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bloc = KiwiContainer().resolve<EditPasswordBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(text: LocaleKeys.change_password_change_password.tr()),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppInput(
                      backgroundColor: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return LocaleKeys
                              .change_password_please_enter_your_old_password_again_at_least_six_letters
                              .tr();
                        }
                        return null;
                      },
                      controller: _bloc.oldPasswordController,
                      labelText: LocaleKeys.change_password_old_password.tr(),
                      prefixIcon: Assets.icons.password.path,
                      inputType: InputType.password,
                      textInputAction: TextInputAction.done,
                    ),
                    AppInput(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return LocaleKeys
                              .reset_password_please_enter_new_password_in_6_letters_at_min
                              .tr();
                        }
                        return null;
                      },
                      controller: _bloc.newPasswordController,
                      labelText: LocaleKeys.reset_password_new_password.tr(),
                      prefixIcon: Assets.icons.password.path,
                      inputType: InputType.password,
                      textInputAction: TextInputAction.done,
                      backgroundColor: true,
                    ),
                    AppInput(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return LocaleKeys
                              .reset_password_please_enter_new_password_again
                              .tr();
                        } else if (value != _bloc.newPasswordController.text) {
                          return LocaleKeys
                              .change_password_two_passwords_not_matching
                              .tr();
                        }
                        return null;
                      },
                      controller: _bloc.confirmNewPasswordController,
                      labelText:
                          LocaleKeys.reset_password_confirm_new_password.tr(),
                      prefixIcon: Assets.icons.password.path,
                      inputType: InputType.password,
                      textInputAction: TextInputAction.done,
                      backgroundColor: true,
                    ),
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.r),
        child: BlocConsumer(
          bloc: _bloc,
          listener: (context, state) {
            if (state is EditPasswordSuccessState) {}
            push(const EditProfileScreen());
          },
          builder: (context, state) {
            return AppButton(
                isLoading: state is EditPasswordLoadingState,
                text: LocaleKeys.change_password_change_password.tr(),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _bloc.add(PostEditPasswordDataEvent(context: context));
                  }
                });
          },
        ),
      ),
    );
  }
}
