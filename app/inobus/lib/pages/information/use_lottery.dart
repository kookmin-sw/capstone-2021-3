import 'package:flutter/material.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/app_images.dart';
import 'package:inobus/widgets/page_info_one_image.dart';

class LotteryFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageInforamtionOneImage(
      mainImg: AppImages.smilePurple.image(),
      textList: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '추천권은 최대 3번!\n',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "\n추첨권은 달마다 최대 3번 부여됩니다.\n",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          TextSpan(
            text: "\n매달 푸짐한 상품들이 기다리고 있습니다!\n",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class LotterySecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageInforamtionOneImage(
      mainImg: AppImages.smilePurple.image(),
      textList: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '1회당 10포인트!\n',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "\n쓰샘 사용 4번째부터 1회당 10포인트씩 적립됩니다.\n(최초 3회 추첨권 부여)\n",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          TextSpan(
            text: "\n[메뉴]-[추첨권/포인트]에서 \n적립된 내역을 확인할 수 있습니다.\n",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          TextSpan(
            text: "\n쌓인 포인트로 업사이클링 상품을\n저렴하게 구입할 수 있어요!\n",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
