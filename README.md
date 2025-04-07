# 🛍️ Flutter 쇼핑 앱 프로젝트

## 소개
Flutter 기반의 커머스 앱 프로젝트입니다. 실제 커머스 서비스처럼 카테고리 필터링, 상품 상세 페이지, 무한 스크롤 기능 등을 구현하였습니다.
es3_seller 는 판매자용 앱이며(구현중) es3_frontend는 일반 유저의 앱입니다.

# ES3_frontend
## 주요 기능
- 홈 화면 상품 리스트 및 랭킹
- 상품 상세 페이지
- 카테고리 필터링 (상위/하위 분류)
- 무한 스크롤 / Pull to Refresh
- 에러 및 로딩 처리
- 서버 연동 (Spring Boot + QueryDSL)

## 기술 스택
- Flutter / Riverpod / go_router / Dio / Retrofit
- Spring Boot / QueryDSL / JWT
- CustomScrollView + SliverGrid 기반 무한 스크롤

## 화면 구성
- 홈 화면 (무한 스크롤 리스트)
- ![Kapture 2025-04-07 at 14 01 58](https://github.com/user-attachments/assets/6a445f15-a816-4db2-ab0b-ef38ef53f61b)
- 상품 상세
- 장바구니
- ![Kapture 2025-04-07 at 14 30 13](https://github.com/user-attachments/assets/082a0a7f-cc09-49b8-8edf-20e10caa9e45)
- 카테고리 별 필터링
- ![Kapture 2025-04-07 at 14 12 27](https://github.com/user-attachments/assets/d0d8399e-0617-4b90-88ae-5cc215b6e338)
- 마이페이지
- ![Kapture 2025-04-07 at 14 27 05](https://github.com/user-attachments/assets/9fb8762a-0629-4a1b-9f2d-b21178145d9a)


## 개발 환경
- Flutter 3.x
- Dart 3.x
- Android / iOS / Web 지원

## 사용 방법
1. 서버 실행
2. Flutter 앱 실행
