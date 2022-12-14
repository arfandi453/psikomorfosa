import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../imports.dart';

class ChatIcon extends StatelessWidget {
  const ChatIcon({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16, top: 8, bottom: 8),
      child: GestureDetector(
        onTap: ChatRoutes.toChats,
        child: Badge(
          position: BadgePosition.topEnd(end: -6, top: -2),
          child: Icon(
            FontAwesomeIcons.facebookMessenger,
            size: 32,
          ),
        ),
      ),
    );
  }
}
