import 'package:flutter/material.dart';
import 'package:thimar_driver/core/widgets/custom_appbar.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(text: "البيانات الشخصية"),
    );
  }
}
