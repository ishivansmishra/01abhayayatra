// Additional Pages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Color, FontWeight, HapticFeedback, Offset, Size, TextAlign, TextInputType, VoidCallback;
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
        actions: [
          IconButton(
            icon: Icon(Icons.layers),
            onPressed: () => _showMapOptions(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[100]!, Colors.purple[300]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 100, color: Colors.purple[600]),
                  SizedBox(height: 20),
                  Text(
                    'Interactive Map View',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(focusedMember != null
                      ? '$focusedMember\'s location would be shown here'
                      : 'Family locations would be shown here'),
                  SizedBox(height: 20),
                  Card(
                    margin: EdgeInsets.all(20),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text('Live Locations:', style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          _buildLocationItem('Mom', 'Goa Beach Resort', Colors.green),
                          _buildLocationItem('Uncle', 'Hotel Taj', Colors.green),
                          _buildLocationItem('Dad', 'Last seen: Mumbai', Colors.orange),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () => _centerOnMyLocation(context),
              child: Icon(Icons.my_location),
              backgroundColor: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationItem(String name, String location, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8),
          Text('$name: $location'),
        ],
      ),
    );
  }

  void _showMapOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Map Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Standard View'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.satellite),
              title: Text('Satellite View'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.traffic),
              title: Text('Traffic View'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _centerOnMyLocation(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Centering map on your location...')),
    );
  }
}

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  final TextEditingController _nameController = TextEditingController(text: 'Sudarshan');
  final TextEditingController _emailController = TextEditingController(text: 'sudarshan@email.com');
  final TextEditingController _phoneController = TextEditingController(text: '+91 98765 43210');
  final TextEditingController _dobController = TextEditingController(text: 'January 15, 1990');
  final TextEditingController _addressController = TextEditingController(text: 'Mumbai, Maharashtra, India');
  final TextEditingController _emergencyContactController = TextEditingController(text: 'Father (+91 98765 43211)');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (_isEditing && _formKey.currentState!.validate()) {
                setState(() {
                  _isEditing = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Profile updated successfully')),
                );
              } else {
                setState(() {
                  _isEditing = !_isEditing;
                });
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Basic Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    _buildInfoField('Full Name', _nameController, Icons.person),
                    _buildInfoField('Email', _emailController, Icons.email),
                    _buildInfoField('Phone', _phoneController, Icons.phone),
                    _buildInfoField('Date of Birth', _dobController, Icons.cake),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contact Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    _buildInfoField('Address', _addressController, Icons.home),
                    _buildInfoField('Emergency Contact', _emergencyContactController, Icons.contact_phone),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Account Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    ListTile(
                      leading: Icon(Icons.verified_user, color: Colors.green),
                      title: Text('Verification Status'),
                      subtitle: Text('Verified'),
                      trailing: Icon(Icons.check_circle, color: Colors.green),
                    ),
                    ListTile(
                      leading: Icon(Icons.calendar_today, color: Colors.blue),
                      title: Text('Member Since'),
                      subtitle: Text('January 2024'),
                    ),
                    ListTile(
                      leading: Icon(Icons.security, color: Colors.orange),
                      title: Text('Tourist ID'),
                      subtitle: Text('TID12345'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        enabled: _isEditing,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
          filled: !_isEditing,
          fillColor: _isEditing ? null : Colors.grey[100],
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}

class TravelHistoryPage extends StatefulWidget {
  @override
  _TravelHistoryPageState createState() => _TravelHistoryPageState();
}

class _TravelHistoryPageState extends State<TravelHistoryPage> {
  final List<Map<String, dynamic>> travelHistory = [
    {
      'destination': 'Goa',
      'dates': 'Dec 20-25, 2024',
      'duration': '5 days',
      'status': 'Completed',
      'rating': 4.5,
      'highlights': ['Beach parties', 'Water sports', 'Local cuisine'],
      'expenses': '₹35,000',
      'companions': '6 friends',
    },
    {
      'destination': 'Rishikesh',
      'dates': 'Nov 10-14, 2024',
      'duration': '4 days',
      'status': 'Completed',
      'rating': 5.0,
      'highlights': ['River rafting', 'Yoga sessions', 'Temple visits'],
      'expenses': '₹25,000',
      'companions': 'Solo trip',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel History'),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: travelHistory.length,
        itemBuilder: (context, index) {
          final trip = travelHistory[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange[100],
                child: Icon(Icons.flight, color: Colors.orange[600]),
              ),
              title: Text(trip['destination'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(trip['dates']),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      Text(' ${trip['rating']}'),
                      SizedBox(width: 16),
                      Text('${trip['duration']} • ${trip['companions']}'),
                    ],
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Highlights:', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      ...trip['highlights']
                          .map<Widget>((highlight) => Padding(
                        padding: EdgeInsets.only(left: 16, bottom: 4),
                        child: Row(
                          children: [
                            Icon(Icons.check, size: 16, color: Colors.green),
                            SizedBox(width: 8),
                            Text(highlight),
                          ],
                        ),
                      ))
                          .toList(),
                      SizedBox(height: 12),
                      Text('Total Expenses: ${trip['expenses']}',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EmergencyContactsPage extends StatefulWidget {
  @override
  _EmergencyContactsPageState createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  List<Map<String, String>> contacts = [
    {'name': 'Father', 'relation': 'Father', 'phone': '+91 98765 43210', 'priority': 'Primary'},
    {'name': 'Mother', 'relation': 'Mother', 'phone': '+91 98765 43211', 'priority': 'Primary'},
    {'name': 'Local Police', 'relation': 'Emergency Service', 'phone': '112', 'priority': 'Emergency'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addEmergencyContact(context),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          Color priorityColor = contact['priority'] == 'Primary' ? Colors.red : Colors.orange;

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: priorityColor.withOpacity(0.1),
                child: Icon(Icons.person, color: priorityColor),
              ),
              title: Text(contact['name']!, style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('${contact['relation']} • ${contact['phone']}'),
              trailing: IconButton(
                icon: Icon(Icons.call, color: Colors.green),
                onPressed: () => _callContact(contact['phone']!),
              ),
            ),
          );
        },
      ),
    );
  }

  void _addEmergencyContact(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Emergency Contact'),
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
              if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {
                setState(() {
                  contacts.add({
                    'name': nameController.text,
                    'phone': phoneController.text,
                    'relation': 'Contact',
                    'priority': 'Secondary',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Emergency contact added successfully')),
                );
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _callContact(String phone) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling $phone...')),
    );
  }
}

class TripDetailPage extends StatelessWidget {
  final Map<String, dynamic> trip;
  final bool isHistory;

  TripDetailPage({required this.trip, this.isHistory = false});

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
                    Text('Description: ${trip['description']}'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_city, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text('Safe Zones', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Configure your safe zones here'),
          ],
        ),
      ),
    );
  }
}

class SafetyTipsPage extends StatelessWidget {
  final List<Map<String, String>> tips = [
    {
      'title': 'Share Your Itinerary',
      'description': 'Always share your travel plans with family and friends.',
    },
    {
      'title': 'Keep Emergency Contacts Updated',
      'description': 'Regularly update your emergency contacts.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safety Tips'),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          final tip = tips[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(tip['title']!),
              subtitle: Text(tip['description']!),
            ),
          );
        },
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
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Location Privacy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  SwitchListTile(
                    title: Text('Share location with family'),
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
        ],
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
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.support_agent),
              title: Text('Contact Support'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening support...')),
                );
              },
            ),
          ),
        ],
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
          return Card(
            child: ListTile(
              leading: Icon(Icons.notifications),
              title: Text(notification.title),
              subtitle: Text(notification.message),
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
        child: Text('Edit trip functionality would be implemented here'),
      ),
    );
  }
}

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
      description:
      "AI-powered safety monitoring system with blockchain-secured digital IDs for safe and secure travel experience.",
      icon: Icons.security,
      color: Colors.blue,
    ),
    SlideData(
      title: "Digital Tourist ID",
      subtitle: "Blockchain-Secured Identity",
      description:
      "Get your secure digital ID at entry points. Includes KYC verification, trip itinerary, and emergency contacts.",
      icon: Icons.credit_card,
      color: Colors.green,
    ),
    SlideData(
      title: "Real-Time Safety Monitoring",
      subtitle: "AI-Powered Protection",
      description:
      "Auto safety score calculation, geo-fencing alerts, and anomaly detection for your complete protection.",
      icon: Icons.location_on,
      color: Colors.orange,
    ),
    SlideData(
      title: "Emergency Response",
      subtitle: "Instant Help When Needed",
      description:
      "Panic button with live location sharing, automatic alerts to police units and emergency contacts.",
      icon: Icons.emergency,
      color: Colors.red,
    ),
    SlideData(
      title: "Family Tracking",
      subtitle: "Stay Connected",
      description:
      "Optional real-time tracking for families, multilingual support, and IoT integration for high-risk areas.",
      icon: Icons.family_restroom,
      color: Colors.purple,
    ),
    SlideData(
      title: "Trip Planner",
      subtitle: "Plan Like a Pro",
      description:
      "Create itineraries, get suggestions, and receive alerts about your planned destinations.",
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
                        color: currentPage == index
                            ? slides[currentPage].color
                            : Colors.grey[300],
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
                        backgroundColor:
                        currentPage > 0 ? slides[currentPage].color : Colors.grey,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
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
    final width = MediaQuery.of(context).size.width * 0.7;

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
          Container(
            width: width,
            child: Text(
              slide.title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                shadows: [
                  Shadow(
                    color: Colors.black12,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 18),
          Container(
            width: width * 0.8,
            child: Text(
              slide.subtitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: slide.color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 28),
          Container(
            width: width,
            child: Text(
              slide.description,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
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
                tooltip: "Notifications",
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
                    constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      '${notifications.where((n) => !n.read).length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.emergency),
            tooltip: "Emergency Panic",
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

// Dashboard Page
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
                  onPressed: () => _navigateToSafeZones(context),
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
                  onPressed: () => _navigateToSafetyTips(context),
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

  void _navigateToSafeZones(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SafeZonesPage()),
    );
  }

  void _navigateToSafetyTips(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SafetyTipsPage()),
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
                onPressed: () => _openMapView(context),
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
                    onSelected: (value) => _handleMemberAction(value, member['name']!),
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

  void _openMapView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapViewPage()),
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

// Trip Planner Page
class TripPlannerPage extends StatefulWidget {
  @override
  _TripPlannerPageState createState() => _TripPlannerPageState();
}

class _TripPlannerPageState extends State<TripPlannerPage> {
  List<Map<String, dynamic>> trips = [
    {
      'destination': 'Northeast India',
      'duration': 7,
      'status': 'Upcoming',
      'startDate': '2025-02-15',
      'endDate': '2025-02-22',
      'description': 'Explore the pristine beauty of Northeast India with visits to Shillong, Cherrapunji, and Kaziranga National Park.',
      'budget': '₹45,000',
      'companions': '4 people',
    },
    {
      'destination': 'Rishikesh',
      'duration': 4,
      'status': 'Completed',
      'startDate': '2024-12-10',
      'endDate': '2024-12-14',
      'description': 'Spiritual journey with river rafting, yoga sessions, and temple visits in the yoga capital of the world.',
      'budget': '₹25,000',
      'companions': 'Solo',
      'rating': 5.0,
      'highlights': ['River rafting', 'Yoga sessions', 'Temple visits'],
    },
    {
      'destination': 'Goa Beaches',
      'duration': 5,
      'status': 'In Progress',
      'startDate': '2025-01-20',
      'endDate': '2025-01-25',
      'description': 'Beach vacation with water sports, local cuisine, and historical sightseeing in North and South Goa.',
      'budget': '₹35,000',
      'companions': '6 people',
    },
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
                'My Trips',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              FloatingActionButton(
                mini: true,
                onPressed: () => _showAddTripDialog(context),
                child: Icon(Icons.add),
                backgroundColor: Colors.teal,
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Plan, track, and manage all your adventures',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];
              Color statusColor;
              switch (trip['status']) {
                case 'Completed':
                  statusColor = Colors.green;
                  break;
                case 'In Progress':
                  statusColor = Colors.orange;
                  break;
                default:
                  statusColor = Colors.blue;
              }
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 6,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _showTripDetails(context, trip),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blue[200]!, Colors.blue[400]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.landscape,
                                  size: 60,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Chip(
                                  label: Text(
                                    trip['status'] as String,
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                  backgroundColor: statusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              trip['destination'] as String,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                                SizedBox(width: 4),
                                Text(
                                  '${trip['startDate']} to ${trip['endDate']}',
                                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                                SizedBox(width: 4),
                                Text(
                                  'Duration: ${trip['duration']} days',
                                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              trip['description'] as String,
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.monetization_on, size: 16, color: Colors.green),
                                    SizedBox(width: 4),
                                    Text(
                                      trip['budget'] as String,
                                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                                    ),
                                  ],
                                ),
                                PopupMenuButton(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(child: Text('Edit Trip'), value: 'edit'),
                                    PopupMenuItem(child: Text('Duplicate'), value: 'duplicate'),
                                    PopupMenuItem(child: Text('Share'), value: 'share'),
                                    PopupMenuItem(child: Text('Delete'), value: 'delete'),
                                  ],
                                  onSelected: (value) => _handleTripAction(value.toString(), index),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAddTripDialog(BuildContext context) {
    final TextEditingController destinationController = TextEditingController();
    final TextEditingController durationController = TextEditingController();
    final TextEditingController startDateController = TextEditingController();
    final TextEditingController budgetController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Trip'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: destinationController,
                decoration: InputDecoration(
                  labelText: 'Destination',
                  prefixIcon: Icon(Icons.place),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: durationController,
                decoration: InputDecoration(
                  labelText: 'Duration (days)',
                  prefixIcon: Icon(Icons.timer),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: startDateController,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  prefixIcon: Icon(Icons.calendar_today),
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
                controller: budgetController,
                decoration: InputDecoration(
                  labelText: 'Budget',
                  prefixIcon: Icon(Icons.monetization_on),
                ),
                keyboardType: TextInputType.number,
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
                    'status': 'Upcoming',
                    'startDate': startDateController.text,
                    'endDate': startDateController.text,
                    'description': 'Exciting trip to ${destinationController.text}',
                    'budget': budgetController.text.isNotEmpty ? '₹${budgetController.text}' : 'Not set',
                    'companions': 'Solo',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('New trip added successfully!')),
                );
              }
            },
            child: Text('Add Trip'),
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
    switch (action) {
      case 'edit':
        _editTrip(index);
        break;
      case 'duplicate':
        setState(() {
          var newTrip = Map<String, dynamic>.from(trips[index]);
          newTrip['destination'] = '${newTrip['destination']} (Copy)';
          newTrip['status'] = 'Upcoming';
          trips.add(newTrip);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Trip duplicated successfully')),
        );
        break;
      case 'share':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sharing trip: ${trips[index]['destination']}')),
        );
        break;
      case 'delete':
        _showDeleteConfirmation(index);
        break;
    }
  }

  void _editTrip(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTripPage(
          trip: trips[index],
          onSave: (updatedTrip) {
            setState(() {
              trips[index] = updatedTrip;
            });
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Trip'),
        content: Text('Are you sure you want to delete "${trips[index]['destination']}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                trips.removeAt(index);
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
}