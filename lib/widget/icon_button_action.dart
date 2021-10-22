import 'package:flutter/material.dart';

class IconButtonAction extends StatelessWidget {
  final BuildContext context;
  final String tooltipMsg;
  final IconData icon;
  final String pushNamed;
  final String pushNamedArg;
  const IconButtonAction({
    Key? key,
    required this.tooltipMsg,
    required this.icon,
    required this.pushNamed,
    required this.context,
    this.pushNamedArg = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltipMsg,
      icon: Icon(icon),
      onPressed: () async {
        Navigator.pushNamed(
          context,
          pushNamed,
          arguments: pushNamedArg,
        );
      },
    );
  }
}
