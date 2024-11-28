import 'package:realestate/common/widgets/common/height-spacer.dart';
import 'package:realestate/common/widgets/common/width-spacer.dart';
import 'package:realestate/theme/text-styles.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late AnimationController _containerController;
  late AnimationController _iconController;

  late Animation<Offset> _containerSlideAnimation;
  late Animation<double> _iconPositionAnimation;
  late Animation<double> _textOpacityAnimation;

  late AnimationController _iconController1;
  late AnimationController _iconController2;
  late AnimationController _iconController3;

  late Animation<double> _iconPositionAnimation1;
  late Animation<double> _textOpacityAnimation1;

  late Animation<double> _iconPositionAnimation2;
  late Animation<double> _textOpacityAnimation2;

  late Animation<double> _iconPositionAnimation3;
  late Animation<double> _textOpacityAnimation3;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  late Animation<double> _textSlideAnimation;
  late Animation<Offset> _slideLocationAnimation;

  bool _isRowVisible = true;

  @override
  void initState() {
    super.initState();

    // Animation for sliding in the container
    _containerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _containerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Starts off-screen at the bottom
      end: Offset.zero, // Ends at its original position
    ).animate(
      CurvedAnimation(parent: _containerController, curve: Curves.easeOut),
    );

    // Animation for sliding the icon and fading in the text
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _iconController1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _iconController2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _iconController3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _iconPositionAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _iconController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _iconController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );
    _iconPositionAnimation1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _iconController1,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _textOpacityAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _iconController1,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    _iconPositionAnimation2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _iconController2,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _textOpacityAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _iconController2,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    _iconPositionAnimation3 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _iconController3,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _textOpacityAnimation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _iconController3,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    _textSlideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _slideLocationAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Starts off-screen to the left
      end: Offset.zero, // Ends in its original position
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the container animation first, then start the icon animation
    _containerController.forward().then((_) {
      _iconController.forward();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      _iconController1.forward();
    }).then((_) {
      _iconController2.forward();
    }).then((_) {
      _iconController3.forward();
    });

    //buy and rent section

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start the animations after a slight delay
    /* Future.delayed(const Duration(milliseconds: 500), () {
      _controller.forward();
    });*/
    _controller.forward().then((_) {
      setState(() {
        _isRowVisible = false;
      });
    });
  }

  @override
  void dispose() {
    _containerController.dispose();
    _iconController.dispose();
    _iconController1.dispose();
    _iconController2.dispose();
    _iconController3.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;
    return Scaffold(
      body: ListView(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white, // White color starts at the top left
                  Colors.orange.withOpacity(0.2),
                  // Colors.orange, // Brown color fades in
                ],
                stops: [0.2, 1.0],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SlideTransition(
                              position: _slideLocationAnimation,
                              child: Container(
                                height: screenHeight * 0.06,
                                width: screenWidth * 0.35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white54,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                              255, 184, 181, 181)
                                          .withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.brown,
                                    ),
                                    Text(
                                      "Saint Petersburg",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13,
                                        color: Colors.brown,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ScaleTransition(
                              scale: _scaleAnimation,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    "assets/images/profile.jpg",
                                    fit: BoxFit.cover,
                                    height: screenHeight * 0.07,
                                    width: screenWidth * 0.17,
                                  )),
                            ),
                          ],
                        ),
                        const HeightSpacer(0.03),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hi, Marina",
                                    style: headerText2Style.copyWith(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              FadeTransition(
                                opacity: _textSlideAnimation,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: screenHeight * 0.02, left: 0),
                                  child: Text(
                                    "lets select your perfect place",
                                    style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 73, 52, 44),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 37,
                                    ),
                                  ),
                                ),
                              ),
                              const HeightSpacer(0.03),
                              _isRowVisible
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // First container
                                        ScaleTransition(
                                          scale: _scaleAnimation,
                                          child: buildAnimatedContainer2(
                                            screenHeight: screenHeight,
                                            screenWidth: screenWidth,
                                            backgroundColor:
                                                Colors.orange.withOpacity(0.7),
                                            textColor: Colors.white,
                                            label: "BUY",
                                            offers: 1034,
                                          ),
                                        ),
                                        // Second container
                                        ScaleTransition(
                                          scale: _scaleAnimation,
                                          child: buildAnimatedContainer2(
                                            screenHeight: screenHeight,
                                            screenWidth: screenWidth,
                                            backgroundColor: Colors.white54,
                                            textColor: Colors.brown,
                                            label: "RENT",
                                            offers: 2212,
                                            isRounded:
                                                false, // To make it rectangular
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const HeightSpacer(0.03),
                  Container(
                    height: screenHeight * 0.7,
                    width: screenWidth,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50))),
                    child: Column(
                      children: [
                        const HeightSpacer(0.01),
                        Center(
                          child: SlideTransition(
                            position: _containerSlideAnimation,
                            child: Container(
                              height: size.height * 0.25,
                              width: size.width * 0.98,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/apartment1.jpg"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(45)),
                              ),
                              child: Column(
                                children: [
                                  HeightSpacer(0.19),
                                  Center(
                                    child: Container(
                                      height: size.height * 0.05,
                                      width: size.width * 0.8,
                                      decoration: BoxDecoration(
                                        color: Colors.white60,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          // Sliding icon animation
                                          AnimatedBuilder(
                                            animation: _iconPositionAnimation,
                                            builder: (context, child) {
                                              return Positioned(
                                                left: _iconPositionAnimation
                                                        .value *
                                                    (size.width * 0.8 -
                                                        size.width * 0.1),
                                                child: Container(
                                                  height: size.height * 0.05,
                                                  width: size.width * 0.1,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                  child: const Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 15,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),

                                          // Fading text animation
                                          AnimatedBuilder(
                                            animation: _textOpacityAnimation,
                                            builder: (context, child) {
                                              return Opacity(
                                                opacity:
                                                    _textOpacityAnimation.value,
                                                child: Center(
                                                  child: Text(
                                                    "Gladkova st., 25",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // First Column with a single large container
                              Column(
                                children: [
                                  SlideTransition(
                                    position: _containerSlideAnimation,
                                    child: buildAnimatedContainer(
                                      context,
                                      screenHeight: screenHeight,
                                      screenWidth: screenWidth,
                                      height: screenHeight * 0.4,
                                      width: screenWidth * 0.47,
                                      imagePath:
                                          "assets/images/apartment2.jpeg",
                                      iconAnimation: _iconPositionAnimation,
                                      textOpacityAnimation:
                                          _textOpacityAnimation,
                                      iconText: "Loius 23",
                                    ),
                                  ),
                                ],
                              ),
                              // Second Column with two smaller containers
                              Column(
                                children: [
                                  HeightSpacer(0.01),
                                  SlideTransition(
                                    position: _containerSlideAnimation,
                                    child: buildAnimatedContainer(
                                      context,
                                      screenHeight: screenHeight,
                                      screenWidth: screenWidth,
                                      height: screenHeight * 0.2,
                                      width: screenWidth * 0.49,
                                      imagePath: "assets/images/apartment3.jpg",
                                      iconAnimation: _iconPositionAnimation,
                                      textOpacityAnimation:
                                          _textOpacityAnimation,
                                      iconText: "crestnov 3",
                                    ),
                                  ),
                                  const HeightSpacer(0.01),
                                  SlideTransition(
                                    position: _containerSlideAnimation,
                                    child: buildAnimatedContainer(
                                      context,
                                      screenHeight: screenHeight,
                                      screenWidth: screenWidth,
                                      height: screenHeight * 0.2,
                                      width: screenWidth * 0.49,
                                      imagePath: "assets/images/apartment4.jpg",
                                      iconAnimation: _iconPositionAnimation,
                                      textOpacityAnimation:
                                          _textOpacityAnimation,
                                      iconText: "krasnog 14",
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAnimatedContainer(
    BuildContext context, {
    required double screenHeight,
    required double screenWidth,
    required double height,
    required double width,
    required String imagePath,
    required Animation<double> iconAnimation,
    required Animation<double> textOpacityAnimation,
    required String iconText,
  }) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(45)),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: screenHeight * 0.02, // Padding from bottom
            left: screenWidth * 0.02, // Padding from left
            child: Container(
              height: screenHeight * 0.05,
              width: width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // Sliding Icon
                  AnimatedBuilder(
                    animation: iconAnimation,
                    builder: (context, child) {
                      return Positioned(
                        left: iconAnimation.value *
                            (width * 0.8 - screenWidth * 0.1),
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.1,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.black54,
                          ),
                        ),
                      );
                    },
                  ),
                  // Fading Text
                  AnimatedBuilder(
                    animation: textOpacityAnimation,
                    builder: (context, child) {
                      return Center(
                        child: Opacity(
                          opacity: textOpacityAnimation.value,
                          child: Text(iconText,
                              style: headerText3Style.copyWith(
                                  color: Colors.black54, fontSize: 18)),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAnimatedContainer2({
    required double screenHeight,
    required double screenWidth,
    required Color backgroundColor,
    required Color textColor,
    required String label,
    required int offers,
    bool isRounded = true,
  }) {
    return Container(
      height: screenHeight * 0.2,
      width: isRounded ? screenWidth * 0.43 : screenWidth * 0.45,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isRounded ? null : BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: headerText3Style.copyWith(
              color: textColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8),
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: offers),
            duration: const Duration(seconds: 2),
            builder: (context, value, child) {
              return Text(
                "$value",
                style: headerText1Style.copyWith(color: textColor),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            "offers",
            style: headerText3Style.copyWith(
              color: textColor,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
