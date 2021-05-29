import 'package:flutter/material.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/models/route_argument.dart';
import 'package:inobus/pages/support/widgets/support_footer.dart';
import 'package:inobus/pages/support/widgets/support_title.dart';
import 'package:inobus/widgets/app_scaffold.dart';

class FaqItem {
  final String question;
  final String answer;

  FaqItem(this.question, this.answer);
}

class FaqPage extends StatelessWidget {
  final faq = [
    FaqItem("쓰샘 위치는 어떻게 아나요?",
        "앱 메인화면에서 사용자의 위치에서 가장 근접한 쓰샘 기기를 확인할 수 잇습니다. 이외의 쓰샘이 설치된 위치를 알고 싶다면 이노버스 홈페이지를 방문해주세요."),
    FaqItem("기기 사용시 몇 포인트가 적립되나요?", "기기 사용시 한 번에 1포인트가 적립됩니다."),
    FaqItem("이용 내역이 궁금해요!", "이용내역은 '메뉴 - 이용내역'을 통해 기관별 이용내역을 확인할 수 있습니다.")
  ];

  Widget _buildFaqList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      itemCount: faq.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          expandedAlignment: Alignment.centerLeft,
          childrenPadding: const EdgeInsets.only(left: 20, bottom: 12),
          title: RichText(
            text: TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: 'Q${index + 1}    ',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    )),
                TextSpan(text: faq[index].question),
              ],
            ),
          ),
          children: [
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: [
                  TextSpan(
                    text: 'A${index + 1}    ',
                    style: TextStyle(
                      color: AppColors.primary.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: faq[index].answer),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

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
            SupportTitle('FAQ'),
            _buildFaqList(context),
            Spacer(),
            SupportFooter(),
          ],
        ),
      ),
    );
  }
}
