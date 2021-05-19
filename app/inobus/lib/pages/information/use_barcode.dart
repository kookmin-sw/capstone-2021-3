import 'package:flutter/material.dart';
import 'package:inobus/app_colors.dart';
import 'package:inobus/app_images.dart';
import 'package:inobus/widgets/page_info_one_image.dart';

class BarcodeFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.05,
          left: screenWidth * 0.1,
          child: Container(
            child: AppImages.device.image(),
            height: screenHeight * 0.3,
          ),
        ),
        Positioned(
          top: screenHeight * 0.2,
          left: screenWidth * 0.55,
          child: Container(
            child: AppImages.phone.image(),
            height: screenHeight * 0.3,
          ),
        ),
        Align(
          alignment: Alignment(0.0, 0.7), // (가로, 세로)
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '기기 전면에 바코드를 스캔해요\n',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "\n앱을 켜고 쓰샘을 찾았다면\n'바코드 열기'버튼을 눌러주세요.\n",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: "\n바코드가 나오면 기기에 스탠해주세요.\n",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BarcodeSecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageInforamtionOneImage(
      mainImg: AppImages.cup.image(),
      textList: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '쓰샘으로 제대로 버려요!\n',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "\n이용하신 일회용 컵을\n쓰샘을 이용해서 버려주세요.\n",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          TextSpan(
            text: "\n비우기-행구기-분류하기-분리하기\n순으로 완벽하게 처리할 수 있습니다.\n",
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

class BarcodeThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageInforamtionOneImage(
      mainImg: AppImages.phone.image(),
      textList: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '보상은 바로바로!\n',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "\n뿌듯한 마음으로 앱을 열고\n",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          TextSpan(
            text: "\n추첨권/포인트 적립 내역을 확인해주세요!\n",
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
