# INOBUS Application

## 설치

1. flutter 설치 : [flutter 설치 가이드 링크](https://flutter.dev/docs/get-started/install)
2. 패키지 설치 :

   ```shell
   cd <프로젝트 폴더>
   flutter pub get
   ```

## Flutter에서 FireBase 사용법
- [Firebase 문서](https://firebase.google.com/docs)
- [Flutter에서 Firebase 사용 가이드](https://firebase.flutter.dev/docs/overview)
- [Firebase를 이용한 소셜 로그인](https://firebase.flutter.dev/docs/auth/social)


## Git hook 설정

- lefthook 설치
  - [lefthook 설치 가이드](https://github.com/Arkweid/lefthook/blob/master/docs/full_guide.md)
  - Windows 10은 [release](https://github.com/Arkweid/lefthook/releases)에서 다운 받은 후 환경변수에 지정
  - lefthook.yml 있는 폴더에서 `lefthook install` 실행
- lefthook-local.yml 파일 작성
  ```yml
  pre-push:
    exclude_tags:
      - backend
  pre-commit:
    exclude_tags:
      - backend
  ```
  
## 참조한 라이브러
- https://pub.dev/packages/http
- https://pub.dev/packages/geolocator
- https://pub.dev/packages/google_maps_flutter
- https://pub.dev/packages/firebase_auth
- https://pub.dev/packages/firebase_core
- https://pub.dev/packages/google_sign_in
- https://pub.dev/packages/json_annotation
- https://pub.dev/packages/package_info
- https://pub.dev/packages/url_launcher
- https://pub.dev/packages/fl_chart
- https://pub.dev/packages/flutter_staggered_grid_view
- https://pub.dev/packages/double_back_to_close_app
- https://pub.dev/packages/barcode_widget
- https://pub.dev/packages/smooth_page_indicator

## 폴더 구조

```
inobus
│ pubspec.yaml
├─android
├─assets/
│  ├─icons
│  └─images
├─ios
└─lib/
   ├─api/
   │  │  api.dart 
   │  │  device.dart
   │  │  device.g.dart
   │  │  orgainzation.dart
   │  │  orgainzation.g.dart
   │  │  user.dart
   │  └─ user.g.dart
   ├─models/
   │  │  auth_service.dart   
   │  └─ route_argument.dart
   ├─pages/
   │  ├─information/
   │  ├─introduction/
   │  └─support/
   │  │  barcode_page.dart
   │  │  information_page.dart
   │  │  map_page.dart
   │  │  market_page.dart
   │  │  pages.dart
   │  │  point_page.dart
   │  │  setting_page.dart
   │  └─ user_history_page.dart
   ├─widgets/
   │  │  app_appbar.dart
   │  │  app_drawer.dart
   │  │  app_scaffold.dart
   │  │  circle_box.dart
   │  │  circle_button.dart
   │  │  login_button.dart
   │  └─ page_info_one_image.dart
   │  app_colors.dart
   │  app_icons.dart
   │  app_images.dart
   │  app_size.dart
   │  app_them.dart
   │  main.dart
   └─ routes.dart
```

## 애플리케이션 기능
### 주요 기능(4)
| 쓰샘 기기 위치 정보 제공 | 사용자 고유 바코드 생성 | 사용자 포인트 조회 | 기관의 사용 랭킹 조회 |
| :---------------------: | :---------------------: | :---------------: | :-------------------: |
| ![Screenshot_20210522-220229](https://user-images.githubusercontent.com/41602422/119292287-0f69cc80-bc8b-11eb-899a-b40e16d1014e.jpg) |                                           ![Screenshot_20210523-212502](https://user-images.githubusercontent.com/41602422/119292306-15f84400-bc8b-11eb-90af-91382cd52949.jpg) |                                           ![Screenshot_20210523-212903](https://user-images.githubusercontent.com/41602422/119292390-3f18d480-bc8b-11eb-9f98-866fb19369f0.jpg) |                                           ![Screenshot_20210523-212455](https://user-images.githubusercontent.com/41602422/119292409-46d87900-bc8b-11eb-9d76-d897873d165d.jpg) |

### 편의 기능

| 편의 기능 |  |  |  |
| :--: |:--: |:--: |:--: |
| ![Screenshot_20210522-220150](https://user-images.githubusercontent.com/41602422/119294992-b4d36f00-bc90-11eb-8e34-b306d563884a.jpg)                                           | ![Screenshot_20210522-220201](https://user-images.githubusercontent.com/41602422/119294998-b735c900-bc90-11eb-9854-1db7e928ce70.jpg)                                           | ![Screenshot_20210524-000414](https://user-images.githubusercontent.com/41602422/119294985-ae44f780-bc90-11eb-90cf-d0889c7a69cd.png)                                           | ![Screenshot_20210522-220412](https://user-images.githubusercontent.com/41602422/119295793-aab27000-bc92-11eb-8428-eac2a4c4a98c.jpg) |
| ![Screenshot_20210522-220255](https://user-images.githubusercontent.com/41602422/119295007-bc931380-bc90-11eb-94d5-27ea5d1e14fa.jpg)                                           | ![Screenshot_20210522-220303](https://user-images.githubusercontent.com/41602422/119295012-be5cd700-bc90-11eb-85fe-3f470d925f7e.jpg)                                           | ![Screenshot_20210522-220354](https://user-images.githubusercontent.com/41602422/119295018-c0bf3100-bc90-11eb-9cb9-86801412c9e7.jpg)                                           | ![Screenshot_20210522-220401](https://user-images.githubusercontent.com/41602422/119295667-560ef500-bc92-11eb-9b43-0c163c941b8e.jpg) |



## 애플리케이션 시연 영상
 ![시연영상(320)](https://user-images.githubusercontent.com/41602422/119291804-104e2e80-bc8a-11eb-8b55-b0ccbc6a96c1.gif)


