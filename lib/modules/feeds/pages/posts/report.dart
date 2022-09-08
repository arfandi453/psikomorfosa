import 'package:flutter/material.dart';

import '../../../../imports.dart';
import '../../data/posts.dart';
import '../../models/post.dart';

class ReportPage extends StatelessWidget {
  final Post? post;

  const ReportPage(
    this.post, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor:  Color.fromRGBO(163, 144, 201, 1),
        title: Text(t.Report),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              t.ReportDesc,
              style: TextStyle(fontFamily: "Nunito",fontSize: 20)
            ),
            SizedBox(height: 30),
            Text(t.ReportReasons ,style :TextStyle(fontFamily: "Nunito",fontSize: 14)),
            Spacer(),
            Text(
              t.ReportNote,
              style: TextStyle(fontFamily: "Nunito",fontSize: 14,color: Colors.grey)
            ),
            SizedBox(height: 20),
            Center(
              child: AppButton(
                t.Report,
                onTap: () async {
                  Navigator.pop(context);
                  BotToast.showText(text: t.ReportThanks);
                  post!.reportedBy.add(authProvider.user!.id);
                  await PostsRepository.reportPost(post!);
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
