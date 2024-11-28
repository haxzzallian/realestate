import 'package:realestate/modules/home/view/homepage.dart';
import 'package:realestate/modules/map/view/map-search.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _isContentLoaded = false;
  int _currentIndex = 2; // Default to "Home"

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start off-screen
      end: Offset(0, 0), // Slide to its position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _loadContent();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadContent() async {
    // Simulate content loading delay
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isContentLoaded = true;
    });
    _controller.forward(); // Start the animation for the bottom nav bar
  }

  final List<Widget> _pages = [
    MapScreen(),
    Center(child: Text('Chat Page', style: TextStyle(fontSize: 24))),
    Homepage(),
    Center(child: Text('Favorite Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Display the selected screen
          _pages[_currentIndex],

          // Animated Bottom Navigation Bar
          if (_isContentLoaded)
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20), // Height from the bottom
                  width: screenWidth * 0.75, // 70% width
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 4), // Shadow below the nav bar
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.search, 0, screenHeight, screenWidth),
                      _buildNavItem(Icons.chat, 1, screenHeight, screenWidth),
                      _buildNavItem(Icons.home, 2, screenHeight, screenWidth),
                      _buildNavItem(
                          Icons.favorite, 3, screenHeight, screenWidth),
                      _buildNavItem(Icons.person, 4, screenHeight, screenWidth),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon, int index, double screenHeight, double screenWidth) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        height: screenHeight * 0.08,
        width: screenWidth * 0.1,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? Colors.orange : Colors.transparent),
        child: Icon(
          icon,
          color: Colors.white,
          size: 27,
        ),
      ),
    );
  }
}
