import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLink extends StatelessWidget {
  final String? url;
  AppLink({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url != null && url!.isNotEmpty
        ? IconButton(
            onPressed: () async {
              bool can = await canLaunch(url!);
              if (can) {
                await launch(url!);
              }
            },
            icon: Icon(AppIconData.linkOn))
        : IconButton(onPressed: null, icon: Icon(AppIconData.linkOff));
  }
}
