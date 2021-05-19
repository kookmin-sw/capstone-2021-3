import 'package:flutter/material.dart';
import 'package:inobus/app_colors.dart';

class SupportFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.22,
      color: Color.fromRGBO(224, 222, 222, 1),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyText2,
          children: [
            TextSpan(text: '카카오톡 친구추가 "이노버스" 후\n'),
            TextSpan(text: '문의주시면 최대한 빠르게 답변드리도록 하겠습니다.'),
            TextSpan(text: '\n\n\n'),
            TextSpan(
              text: '운영시간: 월~금, 10:00 ~ 17:00',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
