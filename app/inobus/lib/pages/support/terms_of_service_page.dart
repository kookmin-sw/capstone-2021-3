import 'package:flutter/material.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/pages/support/widgets/support_footer.dart';
import 'package:inobus/pages/support/widgets/support_title.dart';
import 'package:inobus/widgets/app_scaffold.dart';

class TermsOfServicePage extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;
    return AppScaffold(
      title: argument.title,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      body: Expanded(
        child: Column(
          children: [
            SupportTitle('서비스 이용약관'),
            Text(
              '서비스 이용약관',
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.start,
            ),
            Spacer(),
            SupportFooter(),
          ],
        ),
      ),
    );
  }
}
