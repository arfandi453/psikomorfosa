import 'package:flutter/material.dart';

import '../../../../components/user_list.dart';
import '../../../../imports.dart';

class ReactionsPage extends StatelessWidget {
  final List<String> likeIDs;

  const ReactionsPage(
    this.likeIDs, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: Appbar(
        backgroundColor: Colors.white,
        title: Text(
          t.Likes,
          style: TextStyle(
            fontFamily: "Nunito",
                fontWeight: FontWeight.bold
          )
        ),
      ),
      body: UsersList(usersId: likeIDs),
    );
  }
}
