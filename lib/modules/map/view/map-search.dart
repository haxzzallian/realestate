import 'package:realestate/common/widgets/common/width-spacer.dart';
import 'package:realestate/modules/map/view/components/heatmap.dart';
import 'package:realestate/modules/map/view/components/options_container.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  late GoogleMapController _mapController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation; // Combines zoom-out and shrink
  late Animation<double> _fadeTextAnimation;

  late AnimationController _selectionController;
  late Animation<double> _selectionScaleAnimation;
  bool _showOptions = false; // Track whether the container should be visible
  String _selectedOption = "";

  final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco coordinates
    zoom: 12,
  );

  final String _darkMapStyle = '''
  [
      {
          "elementType": "geometry",
          "stylers": [
              {
                  "color": "#212121"
              }
          ]
      },
      {
          "elementType": "labels.icon",
          "stylers": [
              {
                  "visibility": "off"
              }
          ]
      },
      {
          "elementType": "labels.text.fill",
          "stylers": [
              {
                  "color": "#757575"
              }
          ]
      },
      {
          "elementType": "labels.text.stroke",
          "stylers": [
              {
                  "color": "#212121"
              }
          ]
      },
      {
          "featureType": "road",
          "elementType": "geometry",
          "stylers": [
              {
                  "color": "#38414e"
              }
          ]
      },
      {
          "featureType": "water",
          "elementType": "geometry",
          "stylers": [
              {
                  "color": "#000000"
              }
          ]
      }
  ]
  ''';

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and animation
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Total duration
    );

    _selectionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );

    // Combined Zoom-Out and Shrink Animation
    _scaleAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOut)), // Zoom out
        weight: 50, // First half of the animation
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.5)
            .chain(CurveTween(curve: Curves.easeIn)), // Shrink
        weight: 50, // Second half of the animation
      ),
    ]).animate(_animationController);

    // Fade-Out Animation for Text
    _fadeTextAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 1.0,
            curve: Curves.easeIn), // Fades out during shrink phase
      ),
    );

    _selectionScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _selectionController, curve: Curves.easeOut),
    );

    // Start the animation after the widget builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _selectionController.dispose();
    super.dispose();
  }

  void _toggleOptions() {
    if (_showOptions) {
      // Hide options
      _selectionController.reverse().then((_) {
        setState(() {
          _showOptions = false;
        });
      });
    } else {
      // Show options
      setState(() {
        _showOptions = true;
      });
      _selectionController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;
    return Scaffold(
      body: Stack(
        children: [
          // Google Map as the background
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) {
              _mapController = controller;
              _mapController.setMapStyle(_darkMapStyle); // Apply the dark theme
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),

          // Search and Sort Row
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(45),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(Icons.search, color: Colors.grey),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search location',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.sort, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Heatmaps with zoom-out animation
          _buildZoomOutHeatmap("11 mn p", left: 100, top: 150),
          _buildZoomOutHeatmap("8 mn p", right: 80, top: 200),
          _buildZoomOutHeatmap("15 mn p", left: 50, bottom: 250),
          _buildZoomOutHeatmap("7 mn p", right: 50, bottom: 200),
          _buildZoomOutHeatmap("12 mn p", left: 200, bottom: 300),

          Positioned(
            left: 16,
            bottom: 180,
            child: GestureDetector(
              onTap: _toggleOptions,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.layers,
                  color: Colors.white70,
                  size: 20,
                ),
              ),
            ),
          ),
          // Options container
          if (_showOptions) _buildOptionsContainer(),

          Positioned(
            left: 16,
            right: 16,
            bottom: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_outward_sharp,
                    color: Colors.white70,
                    size: 19,
                  ),
                ),
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.sort, color: Colors.white70),
                      SizedBox(width: 8),
                      Text("List of Variants",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZoomOutHeatmap(String text,
      {double? left, double? right, double? top, double? bottom}) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value, // Combines zoom-out and shrink
            child: Container(
              width: 100, // Adjust as needed
              height: 50, // Adjust as needed
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Text fades out during shrink phase
                  Opacity(
                    opacity: _fadeTextAnimation.value,
                    child: Text(
                      text,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Door icon becomes visible after text fades out
                  if (_scaleAnimation.value <= 0.6) // Show when shrinking
                    Icon(
                      Icons.door_front_door, // Door icon
                      color: Colors.white,
                      size: 24,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOptionsContainer() {
    return Positioned(
      left: -40,
      bottom: 150, // Adjust to position the zoom-out container
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              height: 320,
              width: 350, // Adjust width for the options container
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildOption(Icons.park, "Cosy Area"),
                  _buildOption(Icons.price_check, "Price"),
                  _buildOption(Icons.location_city, "Infrastructure"),
                  _buildOption(Icons.layers_clear, "Without Any Layer"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOption(IconData icon, String text) {
    final isSelected = _selectedOption == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = text;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 50,
            ),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
