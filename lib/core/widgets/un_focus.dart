import 'package:flutter/material.dart';

class UnFocus extends StatefulWidget {
  final Widget? child;

  const UnFocus({super.key, this.child});

  @override
  _UnFocusState createState() => _UnFocusState();
}

class _UnFocusState extends State<UnFocus> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: widget.child,
    );
  }
}
