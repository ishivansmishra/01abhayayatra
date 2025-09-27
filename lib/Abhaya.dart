import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(AbhayayatraApp());
}

class AbhayayatraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abhaya Yatra',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: OnboardingSlides(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SlideData {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;

  SlideData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class OnboardingSlides extends StatefulWidget {
  @override
  _OnboardingSlidesState createState() => _OnboardingSlidesState();
}

class _OnboardingSlidesState extends State<OnboardingSlides> {
  PageController _pageController = PageController();
  int currentPage = 0;

  final List<SlideData> slides = [
    SlideData(
      title: "Welcome to Abhaya Yatra",
      subtitle: "Your Digital Travel Companion",
      description: "AI-powered safety monitoring system with blockchain-secured digital IDs for safe and secure travel experience.",
      icon: Icons.security,
      color: Colors.blue,
    ),
    SlideData(
      title: "Digital Tourist ID",
      subtitle: "Blockchain-Secured Identity",
      description: "Get your secure digital ID at entry points. Includes KYC verification, trip itinerary, and emergency contacts.",
      icon: Icons.credit_card,
      color: Colors.green,
    ),
    SlideData(
      title: "Real-Time Safety Monitoring",
      subtitle: "AI-Powered Protection",
      description: "Auto safety score calculation, geo-fencing alerts, and anomaly detection for your complete protection.",
      icon: Icons.location_on,
      color: Colors.orange,
    ),
    SlideData(
      title: "Emergency Response",
      subtitle: "Instant Help When Needed",
      description: "Panic button with live location sharing, automatic alerts to police units and emergency contacts.",
      icon: Icons.emergency,
      color: Colors.red,
    ),
    SlideData(
      title: "Family Tracking",
      subtitle: "Stay Connected",
      description: "Optional real-time tracking for families, multilingual support, and IoT integration for high-risk areas.",
      icon: Icons.family_restroom,
      color: Colors.purple,
    ),
    SlideData(
      title: "Trip Planner",
      subtitle: "Plan Like a Pro",
      description: "Create itineraries, get suggestions, and receive alerts about your planned destinations.",
      icon: Icons.event_note,
      color: Colors.teal,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: slides.length,
              itemBuilder: (context, index) {
                return SlideWidget(slide: slides[index]);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, slides[currentPage].color.withOpacity(0.1)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    slides.length,
                        (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 8,
                      width: currentPage == index ? 30 : 12,
                      decoration: BoxDecoration(
                        color: currentPage == index ? slides[currentPage].color : Colors.grey[300],
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: currentPage > 0 ? slides[currentPage].color : Colors.grey,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: currentPage > 0 ? 6 : 0,
                      ),
                      onPressed: currentPage > 0
                          ? () {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                          : null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back_ios, size: 16),
                          SizedBox(width: 8),
                          Text('Previous'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: slides[currentPage].color,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 6,
                      ),
                      onPressed: () {
                        if (currentPage < slides.length - 1) {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MainApp()),
                          );
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            currentPage < slides.length - 1 ? 'Next' : 'Get Started',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlideWidget extends StatelessWidget {
  final SlideData slide;
  const SlideWidget({Key? key, required this.slide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              color: slide.color.withOpacity(0.15),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: slide.color.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              slide.icon,
              size: 70,
              color: slide.color,
            ),
          ),
          SizedBox(height: 40),
          Text(
            slide.title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 18),
          Text(
            slide.subtitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: slide.color,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 28),
          Text(
            slide.description,
            style: TextStyle(
              fontSize: 17,
              color: Colors.black54,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Notification Item Model
class NotificationItem {
  String title;
  String message;
  String time;
  String type;
  bool read;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.read,
  });
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Safety Alert Cleared',
      message: 'All safety parameters are normal',
      time: '2 hours ago',
      type: 'safety',
      read: false,
    ),
    NotificationItem(
      title: 'Trip Reminder',
      message: 'Your trip to Goa starts tomorrow',
      time: '1 day ago',
      type: 'trip',
      read: true,
    ),
    NotificationItem(
      title: 'Emergency Contact Updated',
      message: 'Your emergency contact has been successfully updated',
      time: '3 days ago',
      type: 'safety',
      read: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      DashboardPage(),
      SafetyPage(),
      TrackingPage(),
      ProfilePage(),
      TripPlannerPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Abhaya Yatra'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationsPage(notifications: notifications),
                    ),
                  );
                },
              ),
              if (notifications.where((n) => !n.read).isNotEmpty)
                Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(minWidth: 14, minHeight: 14),
                    child: Text(
                      '${notifications.where((n) => !n.read).length}',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.emergency),
            onPressed: () {
              _showPanicDialog(context);
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[600],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.security),
            label: 'Safety',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.location_on),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text('3',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center),
                  ),
                )
              ],
            ),
            label: 'Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'Trip Planner',
          ),
        ],
      ),
    );
  }

  void _showPanicDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emergency, color: Colors.red),
            SizedBox(width: 8),
            Text('Emergency Alert'),
          ],
        ),
        content: Text(
            'Are you in an emergency situation? This will immediately alert local authorities and your emergency contacts.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _triggerEmergencyAlert();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('SEND ALERT', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _triggerEmergencyAlert() {
    HapticFeedback.heavyImpact();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Expanded(child: Text('Emergency alert sent! Help is on the way.')),
          ],
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Track',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
        ),
      ),
    );
  }
}

// Enhanced Dashboard Page
class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isLocationEnabled = true;
  int _safetyScore = 92;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
        setState(() {
          _safetyScore = 92 + (DateTime.now().millisecond % 8);
        });
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Welcome back, Sudarshan',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                Switch(
                  value: _isLocationEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isLocationEnabled = value;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_isLocationEnabled
                            ? 'Location tracking enabled'
                            : 'Location tracking disabled'),
                      ),
                    );
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _showSafetyScoreDetails(context);
              },
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.blue[400]!, Colors.blue[600]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Safety Score',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              '$_safetyScore/100',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _getSafetyRating(_safetyScore),
                              style: TextStyle(color: Colors.white70, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.security, color: Colors.white, size: 60),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStatusCard(
                    'Active Trips',
                    '2',
                    Icons.flight_takeoff,
                    Colors.green,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildStatusCard(
                    'Alerts',
                    '0',
                    Icons.warning,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Recent Activities',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            _buildActivityItem('Check-in at Hotel Taj', '2 hours ago', Icons.hotel, () {
              _showActivityDetails(context, 'Hotel Check-in', 'Successfully checked in at Hotel Taj, Goa. All safety protocols verified.');
            }),
            _buildActivityItem('Safety alert cleared', '1 day ago', Icons.check_circle, () {
              _showActivityDetails(context, 'Safety Alert', 'All safety parameters have been restored to normal levels.');
            }),
            _buildActivityItem('Trip to Goa started', '3 days ago', Icons.flight, () {
              _showActivityDetails(context, 'Trip Started', 'Your trip to Goa has begun. Have a safe journey!');
            }),
            SizedBox(height: 30),
            Text(
              'Quick Actions',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _quickCheckIn(context),
                    icon: Icon(Icons.check_circle),
                    label: Text('Quick Check-in'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _shareLocation(context),
                    icon: Icon(Icons.share_location),
                    label: Text('Share Location'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getSafetyRating(int score) {
    if (score >= 90) return 'Excellent';
    if (score >= 75) return 'Good';
    if (score >= 60) return 'Fair';
    return 'Needs Attention';
  }

  Widget _buildStatusCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Icon(icon, color: Colors.blue[600]),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showActivityDetails(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSafetyScoreDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Safety Score Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildScoreDetail('Location Safety', 95),
            _buildScoreDetail('Network Connectivity', 90),
            _buildScoreDetail('Emergency Contacts', 100),
            _buildScoreDetail('Device Security', 85),
            SizedBox(height: 16),
            Text('Your current safety score is calculated based on various factors including your location safety, device security, and connectivity status.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreDetail(String label, int score) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Row(
            children: [
              Container(
                width: 100,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: score / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: score >= 90 ? Colors.green : score >= 75 ? Colors.orange : Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text('$score%', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  void _quickCheckIn(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quick Check-in'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Confirm your current location for safety check-in?'),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue),
                SizedBox(width: 8),
                Expanded(child: Text('Current Location: Goa Beach Resort')),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Check-in successful! Location recorded.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Check In'),
          ),
        ],
      ),
    );
  }

  void _shareLocation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Share Location'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.family_restroom, color: Colors.blue),
              title: Text('Family Members'),
              subtitle: Text('Share with all family members'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Location shared with family')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_phone, color: Colors.green),
              title: Text('Emergency Contacts'),
              subtitle: Text('Share with emergency contacts'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Location shared with emergency contacts')),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

// Safety Page
class SafetyPage extends StatefulWidget {
  @override
  _SafetyPageState createState() => _SafetyPageState();
}

class _SafetyPageState extends State<SafetyPage> {
  bool _autoCheckin = true;
  bool _familyTracking = true;
  bool _emergencyAlerts = true;
  bool _geofenceAlerts = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Safety Center',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Colors.green[400]!, Colors.green[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Status',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              'SAFE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'All systems normal',
                              style: TextStyle(color: Colors.white70, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.shield, color: Colors.white, size: 60),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatusIndicator('GPS', true),
                      _buildStatusIndicator('Network', true),
                      _buildStatusIndicator('Battery', true),
                      _buildStatusIndicator('Emergency', true),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Safety Settings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  SwitchListTile(
                    title: Text('Auto Check-in'),
                    subtitle: Text('Automatically check-in at safe locations'),
                    value: _autoCheckin,
                    onChanged: (value) {
                      setState(() {
                        _autoCheckin = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Family Tracking'),
                    subtitle: Text('Share location with family members'),
                    value: _familyTracking,
                    onChanged: (value) {
                      setState(() {
                        _familyTracking = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Emergency Alerts'),
                    subtitle: Text('Receive emergency notifications'),
                    value: _emergencyAlerts,
                    onChanged: (value) {
                      setState(() {
                        _emergencyAlerts = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Geofence Alerts'),
                    subtitle: Text('Alerts when entering/leaving safe zones'),
                    value: _geofenceAlerts,
                    onChanged: (value) {
                      setState(() {
                        _geofenceAlerts = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SafeZonesPage())),
                  icon: Icon(Icons.location_city),
                  label: Text('Safe Zones'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SafetyTipsPage())),
                  icon: Icon(Icons.tips_and_updates),
                  label: Text('Safety Tips'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(String label, bool isActive) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isActive ? Icons.check : Icons.close,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

// Tracking Page
class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final List<Map<String, String>> familyMembers = [
    {'name': 'Mom', 'status': 'Safe', 'location': 'Goa Beach Resort', 'lastSeen': '2 min ago'},
    {'name': 'Dad', 'status': 'Offline', 'location': 'Mumbai', 'lastSeen': '2 hours ago'},
    {'name': 'Uncle', 'status': 'Safe', 'location': 'Hotel Taj', 'lastSeen': '5 min ago'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Family Tracking',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.map),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MapViewPage())),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.blue[100],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Location',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Goa Beach Resort, North Goa',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Last updated: Just now',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Family Members',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: familyMembers.length,
            itemBuilder: (context, index) {
              final member = familyMembers[index];
              Color statusColor = member['status'] == 'Safe' ? Colors.green : Colors.red;
              IconData statusIcon = member['status'] == 'Safe' ? Icons.check_circle : Icons.error;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: statusColor.withOpacity(0.1),
                    child: Icon(statusIcon, color: statusColor),
                  ),
                  title: Text(member['name']!, style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(member['location']!),
                      Text('Last seen: ${member['lastSeen']}', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(child: Text('View on Map'), value: 'map'),
                      PopupMenuItem(child: Text('Call'), value: 'call'),
                      PopupMenuItem(child: Text('Message'), value: 'message'),
                    ],
                    onSelected: (value) => _handleMemberAction(value.toString(), member['name']!),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _addFamilyMember(context),
                  icon: Icon(Icons.person_add),
                  label: Text('Add Member'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _shareMyLocation(context),
                  icon: Icon(Icons.share_location),
                  label: Text('Share Location'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleMemberAction(String action, String memberName) {
    switch (action) {
      case 'map':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapViewPage(focusedMember: memberName)),
        );
        break;
      case 'call':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Calling $memberName...')),
        );
        break;
      case 'message':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening message to $memberName...')),
        );
        break;
    }
  }

  void _addFamilyMember(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Family Member'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  familyMembers.add({
                    'name': nameController.text,
                    'status': 'Offline',
                    'location': 'Not available',
                    'lastSeen': 'Never',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Family member added successfully')),
                );
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _shareMyLocation(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Your location has been shared with all family members'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// Profile Page
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue[100],
                    child: Icon(Icons.person, size: 50, color: Colors.blue[600]),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Sudarshan',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Tourist ID: TID12345',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildProfileStat('Trips', '12'),
                      _buildProfileStat('Countries', '3'),
                      _buildProfileStat('Safety Score', '92'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildProfileOption('Personal Information', Icons.person, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PersonalInfoPage()),
            );
          }),
          _buildProfileOption('Travel History', Icons.history, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TravelHistoryPage()),
            );
          }),
          _buildProfileOption('Emergency Contacts', Icons.contact_phone, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmergencyContactsPage()),
            );
          }),
          _buildProfileOption('Privacy Settings', Icons.privacy_tip, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PrivacySettingsPage()),
            );
          }),
          _buildProfileOption('Help & Support', Icons.help, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpSupportPage()),
            );
          }),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _logout(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50),
            ),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildProfileOption(String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue[600]),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OnboardingSlides()),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// Trip Planner Page with Enhanced Images and Features
class TripPlannerPage extends StatefulWidget {
  @override
  _TripPlannerPageState createState() => _TripPlannerPageState();
}

class _TripPlannerPageState extends State<TripPlannerPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  List<Map<String, dynamic>> trips = [
    {
      'destination': 'Northeast India',
      'duration': 7,
      'status': 'Upcoming',
      'image': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&h=600&fit=crop',
      'startDate': '2025-02-15',
      'endDate': '2025-02-22',
      'description': 'Explore the pristine beauty of Northeast India with visits to Shillong, Cherrapunji, and Kaziranga National Park. Experience untouched nature, unique culture, and breathtaking landscapes.',
      'budget': '₹45,000',
      'companions': 'Family (4 people)',
      'weather': 'Pleasant (15-25°C)',
      'rating': null,
      'highlights': ['Kaziranga Wildlife', 'Living Root Bridges', 'Meghalaya Hills', 'Local Tribal Culture'],
    },
    {
      'destination': 'Rishikesh',
      'duration': 4,
      'status': 'Completed',
      'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?w=800&h=600&fit=crop',
      'startDate': '2024-12-10',
      'endDate': '2024-12-14',
      'description': 'Spiritual journey with river rafting, yoga sessions, and temple visits in the yoga capital of the world. Perfect blend of adventure and spirituality.',
      'budget': '₹25,000',
      'companions': 'Solo',
      'weather': 'Cool (10-20°C)',
      'rating': 4.8,
      'highlights': ['White Water Rafting', 'Evening Ganga Aarti', 'Yoga Sessions', 'Adventure Sports'],
    },
    {
      'destination': 'Goa Beaches',
      'duration': 5,
      'status': 'In Progress',
      'image': 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=800&h=600&fit=crop',
      'startDate': '2025-01-20',
      'endDate': '2025-01-25',
      'description': 'Beach vacation with water sports, local cuisine, and historical sightseeing in North and South Goa. Sun, sand, and endless fun!',
      'budget': '₹35,000',
      'companions': 'Friends (6 people)',
      'weather': 'Tropical (22-32°C)',
      'rating': null,
      'highlights': ['Beach Parties', 'Water Sports', 'Portuguese Architecture', 'Seafood Cuisine'],
    },
    {
      'destination': 'Rajasthan Heritage',
      'duration': 8,
      'status': 'Planning',
      'image': 'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=800&h=600&fit=crop',
      'startDate': '2025-03-10',
      'endDate': '2025-03-18',
      'description': 'Royal palaces, desert safaris, and rich cultural heritage. Experience the grandeur of Rajasthan with visits to Jaipur, Udaipur, and Jaisalmer.',
      'budget': '₹60,000',
      'companions': 'Partner',
      'weather': 'Warm (20-35°C)',
      'rating': null,
      'highlights': ['Desert Safari', 'Palace Hotels', 'Camel Rides', 'Folk Music'],
    },
    {
      'destination': 'Kerala Backwaters',
      'duration': 6,
      'status': 'Wishlist',
      'image': 'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=800&h=600&fit=crop',
      'startDate': '2025-04-15',
      'endDate': '2025-04-21',
      'description': 'Serene backwaters, lush green landscapes, and Ayurvedic treatments. Gods own country awaits with houseboats and spice plantations.',
      'budget': '₹40,000',
      'companions': 'Family (3 people)',
      'weather': 'Humid (25-35°C)',
      'rating': null,
      'highlights': ['Houseboat Stay', 'Spice Gardens', 'Ayurveda Spa', 'Traditional Dance'],
    },
  ];

  String selectedFilter = 'All';
  List<String> filterOptions = ['All', 'Upcoming', 'In Progress', 'Completed', 'Planning', 'Wishlist'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredTrips {
    if (selectedFilter == 'All') return trips;
    return trips.where((trip) => trip['status'] == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeInAnimation,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('My Adventures', style: TextStyle(fontWeight: FontWeight.bold)),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal[400]!, Colors.blue[600]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.explore, size: 80, color: Colors.white.withOpacity(0.7)),
                  ),
                ),
              ),
              backgroundColor: Colors.teal[600],
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _showSearchDialog(context),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () => _showFilterBottomSheet(context),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatsCard(),
                    SizedBox(height: 20),
                    _buildQuickActions(),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Trips (${filteredTrips.length})',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.teal[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            selectedFilter,
                            style: TextStyle(color: Colors.teal[700], fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  if (index >= filteredTrips.length) return null;
                  return _buildEnhancedTripCard(filteredTrips[index], index);
                },
                childCount: filteredTrips.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTripDialog(context),
        label: Text('Plan Trip'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }

  Widget _buildStatsCard() {
    int completedTrips = trips.where((trip) => trip['status'] == 'Completed').length;
    int upcomingTrips = trips.where((trip) => trip['status'] == 'Upcoming' || trip['status'] == 'In Progress').length;
    double totalBudget = trips.fold(0.0, (sum, trip) {
      String budget = trip['budget'].toString().replaceAll('₹', '').replaceAll(',', '');
      return sum + (double.tryParse(budget) ?? 0);
    });

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.purple[400]!, Colors.pink[400]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Text(
              'Travel Statistics',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Completed', completedTrips.toString(), Icons.check_circle),
                _buildStatItem('Upcoming', upcomingTrips.toString(), Icons.schedule),
                _buildStatItem('Total Budget', '₹${(totalBudget / 1000).toStringAsFixed(0)}K', Icons.monetization_on),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    'Explore',
                    Icons.explore,
                    Colors.orange,
                        () => _exploreDestinations(context),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    'AI Planner',
                    Icons.auto_awesome,
                    Colors.purple,
                        () => _generateItinerary(context),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    'Weather',
                    Icons.wb_sunny,
                    Colors.amber,
                        () => _showWeatherInfo(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: Column(
        children: [
          Icon(icon, size: 24),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildEnhancedTripCard(Map<String, dynamic> trip, int index) {
    Color statusColor;
    IconData statusIcon;
    switch (trip['status']) {
      case 'Completed':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'In Progress':
        statusColor = Colors.orange;
        statusIcon = Icons.schedule;
        break;
      case 'Planning':
        statusColor = Colors.blue;
        statusIcon = Icons.edit_calendar;
        break;
      case 'Wishlist':
        statusColor = Colors.purple;
        statusIcon = Icons.favorite;
        break;
      default:
        statusColor = Colors.blue;
        statusIcon = Icons.flight_takeoff;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _showTripDetails(context, trip),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(
                      trip['image'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blue[200]!, Colors.blue[400]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.landscape, size: 60, color: Colors.white.withOpacity(0.7)),
                                SizedBox(height: 8),
                                Text(
                                  trip['destination'],
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            trip['status'] as String,
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (trip['rating'] != null)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              trip['rating'].toString(),
                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            trip['destination'] as String,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        PopupMenuButton(
                          icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 20),
                                  SizedBox(width: 8),
                                  Text('Edit Trip'),
                                ],
                              ),
                              value: 'edit',
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Icon(Icons.copy, size: 20),
                                  SizedBox(width: 8),
                                  Text('Duplicate'),
                                ],
                              ),
                              value: 'duplicate',
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Icon(Icons.share, size: 20),
                                  SizedBox(width: 8),
                                  Text('Share'),
                                ],
                              ),
                              value: 'share',
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Icon(Icons.delete, size: 20, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('Delete', style: TextStyle(color: Colors.red)),
                                ],
                              ),
                              value: 'delete',
                            ),
                          ],
                          onSelected: (value) => _handleTripAction(value.toString(), index),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                        SizedBox(width: 6),
                        Text(
                          '${trip['startDate']} to ${trip['endDate']}',
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                        SizedBox(width: 6),
                        Text(
                          '${trip['duration']} days • ${trip['companions']}',
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.wb_sunny, size: 16, color: Colors.amber),
                        SizedBox(width: 6),
                        Text(
                          trip['weather'],
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      trip['description'] as String,
                      style: TextStyle(fontSize: 14, color: Colors.grey[800], height: 1.4),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: trip['highlights']
                          .map<Widget>((highlight) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.blue[200]!),
                        ),
                        child: Text(
                          highlight,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.green[200]!),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.monetization_on, size: 18, color: Colors.green[700]),
                              SizedBox(width: 6),
                              Text(
                                trip['budget'] as String,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => _showTripDetails(context, trip),
                              icon: Icon(Icons.info_outline),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.blue[50],
                                foregroundColor: Colors.blue[700],
                              ),
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              onPressed: () => _shareTrip(trip),
                              icon: Icon(Icons.share),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.green[50],
                                foregroundColor: Colors.green[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Search Trips'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Search destinations...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onChanged: (value) {
            // Implement search functionality
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Trips',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: filterOptions.map((filter) => FilterChip(
                label: Text(filter),
                selected: selectedFilter == filter,
                onSelected: (selected) {
                  setState(() {
                    selectedFilter = filter;
                  });
                  Navigator.pop(context);
                },
                selectedColor: Colors.teal[100],
                checkmarkColor: Colors.teal[700],
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTripDialog(BuildContext context) {
    final TextEditingController destinationController = TextEditingController();
    final TextEditingController durationController = TextEditingController();
    final TextEditingController startDateController = TextEditingController();
    final TextEditingController budgetController = TextEditingController();
    final TextEditingController companionsController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Plan New Trip'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: destinationController,
                decoration: InputDecoration(
                  labelText: 'Destination',
                  prefixIcon: Icon(Icons.place),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: durationController,
                      decoration: InputDecoration(
                        labelText: 'Duration (days)',
                        prefixIcon: Icon(Icons.timer),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: budgetController,
                      decoration: InputDecoration(
                        labelText: 'Budget (₹)',
                        prefixIcon: Icon(Icons.monetization_on),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                controller: startDateController,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (picked != null) {
                    startDateController.text = picked.toString().split(' ')[0];
                  }
                },
                readOnly: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: companionsController,
                decoration: InputDecoration(
                  labelText: 'Companions',
                  prefixIcon: Icon(Icons.people),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (destinationController.text.isNotEmpty &&
                  durationController.text.isNotEmpty &&
                  startDateController.text.isNotEmpty) {
                setState(() {
                  trips.add({
                    'destination': destinationController.text,
                    'duration': int.tryParse(durationController.text) ?? 1,
                    'status': 'Planning',
                    'image': 'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=800&h=600&fit=crop',
                    'startDate': startDateController.text,
                    'endDate': startDateController.text,
                    'description': descriptionController.text.isNotEmpty
                        ? descriptionController.text
                        : 'Exciting trip to ${destinationController.text}',
                    'budget': budgetController.text.isNotEmpty ? '₹${budgetController.text}' : 'Not set',
                    'companions': companionsController.text.isNotEmpty ? companionsController.text : 'Solo',
                    'weather': 'Pleasant',
                    'rating': null,
                    'highlights': ['Adventure', 'Culture', 'Nature', 'Food'],
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('New trip planned successfully!'),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Plan Trip', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showTripDetails(BuildContext context, Map<String, dynamic> trip) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripDetailPage(trip: trip),
      ),
    );
  }

  void _handleTripAction(String action, int index) {
    final trip = filteredTrips[index];
    switch (action) {
      case 'edit':
        _editTrip(trip);
        break;
      case 'duplicate':
        setState(() {
          var newTrip = Map<String, dynamic>.from(trip);
          newTrip['destination'] = '${newTrip['destination']} (Copy)';
          newTrip['status'] = 'Planning';
          trips.add(newTrip);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Trip duplicated successfully')),
        );
        break;
      case 'share':
        _shareTrip(trip);
        break;
      case 'delete':
        _showDeleteConfirmation(trip);
        break;
    }
  }

  void _editTrip(Map<String, dynamic> trip) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTripPage(
          trip: trip,
          onSave: (updatedTrip) {
            setState(() {
              int index = trips.indexWhere((t) => t['destination'] == trip['destination']);
              if (index != -1) {
                trips[index] = updatedTrip;
              }
            });
          },
        ),
      ),
    );
  }

  void _shareTrip(Map<String, dynamic> trip) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Share Trip'),
        content: Text('Share "${trip['destination']}" trip details with others?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Trip shared successfully!')),
              );
            },
            child: Text('Share'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(Map<String, dynamic> trip) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Trip'),
        content: Text('Are you sure you want to delete "${trip['destination']}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                trips.removeWhere((t) => t['destination'] == trip['destination']);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Trip deleted successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _exploreDestinations(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExploreDestinationsPage()),
    );
  }

  void _generateItinerary(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.purple),
            SizedBox(width: 8),
            Text('AI Trip Planner'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Let our AI help you plan the perfect trip based on your preferences!'),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Destination',
                prefixIcon: Icon(Icons.place),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Duration (days)',
                prefixIcon: Icon(Icons.timer),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Interests',
                prefixIcon: Icon(Icons.favorite),
                hintText: 'Adventure, Culture, Food, etc.',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Generating personalized itinerary...'),
                  duration: Duration(seconds: 3),
                ),
              );
              // Simulate AI processing
              Future.delayed(Duration(seconds: 3), () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('AI itinerary generated! Check your email.'),
                    backgroundColor: Colors.green,
                  ),
                );
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            child: Text('Generate', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showWeatherInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.wb_sunny, color: Colors.amber),
            SizedBox(width: 8),
            Text('Weather Updates'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Get weather information for your planned destinations:'),
            SizedBox(height: 16),
            ...filteredTrips.take(3).map((trip) => ListTile(
              leading: Icon(Icons.location_on, color: Colors.blue),
              title: Text(trip['destination']),
              subtitle: Text(trip['weather']),
              trailing: Icon(Icons.wb_sunny, color: Colors.amber),
            )).toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Detailed weather forecast sent to your phone!')),
              );
            },
            child: Text('Get Details'),
          ),
        ],
      ),
    );
  }
}

// Additional Pages
class MapViewPage extends StatelessWidget {
  final String? focusedMember;

  MapViewPage({this.focusedMember});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(focusedMember != null ? '$focusedMember\'s Location' : 'Live Map'),
        backgroundColor: Colors.purple[600],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, size: 100, color: Colors.purple[300]),
            SizedBox(height: 20),
            Text('Interactive Map View', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(focusedMember != null ? '$focusedMember\'s location would be shown here' : 'Family locations would be shown here'),
          ],
        ),
      ),
    );
  }
}

class PersonalInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Personal Information Page'),
      ),
    );
  }
}

class TravelHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel History'),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Travel History Page'),
      ),
    );
  }
}

class EmergencyContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Emergency Contacts Page'),
      ),
    );
  }
}

class PrivacySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Settings'),
        backgroundColor: Colors.purple[600],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Privacy Settings Page'),
      ),
    );
  }
}

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        backgroundColor: Colors.teal[600],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Help & Support Page'),
      ),
    );
  }
}

class SafeZonesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safe Zones'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Safe Zones Configuration'),
      ),
    );
  }
}

class SafetyTipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safety Tips'),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Safety Tips Page'),
      ),
    );
  }
}

class ExploreDestinationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Destinations'),
        backgroundColor: Colors.teal[600],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Explore Destinations'),
      ),
    );
  }
}

class TripDetailPage extends StatelessWidget {
  final Map<String, dynamic> trip;

  TripDetailPage({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trip['destination']),
        backgroundColor: Colors.teal[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                trip['image'],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal[200]!, Colors.teal[400]!],
                      ),
                    ),
                    child: Center(
                      child: Icon(Icons.landscape, size: 80, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              trip['destination'],
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Trip Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Text('Duration: ${trip['duration']} days'),
                    SizedBox(height: 8),
                    Text('Budget: ${trip['budget']}'),
                    SizedBox(height: 8),
                    Text('Companions: ${trip['companions']}'),
                    SizedBox(height: 8),
                    Text('Weather: ${trip['weather']}'),
                    SizedBox(height: 16),
                    Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(trip['description']),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditTripPage extends StatelessWidget {
  final Map<String, dynamic> trip;
  final Function(Map<String, dynamic>) onSave;

  EditTripPage({required this.trip, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Trip'),
        backgroundColor: Colors.teal[600],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Edit Trip Page - ${trip['destination']}'),
      ),
    );
  }
}

class NotificationsPage extends StatefulWidget {
  final List<NotificationItem> notifications;

  NotificationsPage({required this.notifications});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: Text('Mark All Read', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: widget.notifications.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_none, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No notifications', style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: widget.notifications.length,
        itemBuilder: (context, index) {
          final notification = widget.notifications[index];
          IconData icon;
          Color color;

          switch (notification.type) {
            case 'safety':
              icon = Icons.security;
              color = Colors.green;
              break;
            case 'trip':
              icon = Icons.flight;
              color = Colors.blue;
              break;
            default:
              icon = Icons.notifications;
              color = Colors.grey;
          }

          return Card(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icon, color: color),
              ),
              title: Text(
                notification.title,
                style: TextStyle(
                  fontWeight: notification.read ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.message),
                  SizedBox(height: 4),
                  Text(
                    notification.time,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
              trailing: notification.read ? null : Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              onTap: () {
                setState(() {
                  notification.read = true;
                });
              },
            ),
          );
        },
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in widget.notifications) {
        notification.read = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('All notifications marked as read')),
    );
  }
}