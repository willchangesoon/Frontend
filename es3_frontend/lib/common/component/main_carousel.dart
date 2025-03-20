import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainCarousel extends StatefulWidget {
  final double aspectRatio;
  final EdgeInsetsGeometry? margin;

  const MainCarousel({
    super.key,
    required this.aspectRatio,
    this.margin,
  });

  @override
  State<MainCarousel> createState() => _MainCarouselState();
}

class _MainCarouselState extends State<MainCarousel> {
  final PageController _pageController = PageController(viewportFraction: 1);
  Timer? _timer;
  int _currentIndex = 0;
  final List<String> imgList = [
    'assets/images/bw/DSCF0741.jpg',
    'assets/images/bw/DSCF1497.jpg',
    'assets/images/bw/DSCF1536.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < imgList.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Stack(
          children: [
            // margin 값을 외부에서 받아 사용 (없으면 기본값 8의 좌우 여백)
            Padding(
              padding: widget.margin ?? const EdgeInsets.symmetric(horizontal: 8),
              child: PageView.builder(
                controller: _pageController,
                itemCount: imgList.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(imgList[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 10,
              right: 12,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Text(
                        '< ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: const Color(0xffCCCCCC)),
                      ),
                      Text(
                        '${_currentIndex + 1} ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      Text(
                        '/${imgList.length} >',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: const Color(0xffCCCCCC)),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
