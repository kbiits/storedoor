import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:storedoor/constants.dart';
import 'package:storedoor/size_config.dart';
import 'package:storedoor/view/screen/home/home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  // Widget _buildImage(String fileName) {
  //   return Align(
  //     child: Image.asset('assets/images/$fileName', width: 350.0),
  //     alignment: Alignment.bottomCenter,
  //   );
  // }

  Widget _buildSvg(String fileName) {
    return Align(
      child: SvgPicture.asset('assets/images/$fileName', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  final bodyTextStyle = GoogleFonts.montserrat(
    color: mPrimaryTextColor,
    fontSize: 16,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    GetStorage storage = new GetStorage();
    storage.write("alreadySeenOnBoardingScreen", true);
    super.dispose();
  }

  void onIntroEnd() {
    Get.offAll(() => HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      dotsDecorator: DotsDecorator(
        activeColor: oPrimaryColor,
      ),
      pages: <PageViewModel>[
        PageViewModel(
          titleWidget: Text(
            "Discover",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 32,
            ),
            textAlign: TextAlign.center,
          ),
          bodyWidget: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Text(
              "Kini semua produk yang anda inginkan berada didalam genggaman ponsel anda",
              style: bodyTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          image: _buildSvg("page1.svg"),
        ),
        PageViewModel(
          titleWidget: Text(
            "Shopping made easy",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 32,
            ),
            textAlign: TextAlign.center,
          ),
          bodyWidget: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Text(
              "Ga bisa keluar rumah ? Pandemi Corona ? Jangan khawatir, anda bisa berbelanja dari rumah hanya dengan ponsel dan jaringan internet",
              style: bodyTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          image: _buildSvg("page2.svg"),
        ),
        PageViewModel(
          titleWidget: Text(
            "Make money from home",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 32,
            ),
            textAlign: TextAlign.center,
          ),
          bodyWidget: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Text(
              "Ga punya duit buat sewa tempat jualan ? Kini anda hanya butuh products dan sudah punya tempat jualan disini",
              style: bodyTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          image: _buildSvg("page3.svg"),
        ),
      ],
      onDone: () => onIntroEnd(),
      done: Container(
        width: getProportionateScreenWidth(80),
        height: getProportionateScreenHeight(35),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(5)),
          color: oPrimaryColor,
        ),
        child: Center(
          child: Text(
            "Done",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
      showNextButton: true,
      showSkipButton: true,
      onSkip: () => onIntroEnd(),
      key: introKey,
      skip: Container(
        width: getProportionateScreenWidth(80),
        height: getProportionateScreenHeight(35),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(5)),
          color: oPrimaryColor,
        ),
        child: Center(
          child: Text(
            "Skip",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
      next: Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
      ),
    );
  }
}
