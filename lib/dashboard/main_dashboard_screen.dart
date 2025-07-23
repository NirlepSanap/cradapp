import 'package:flutter/material.dart';
import 'people_screen.dart';
import 'call_screen.dart';
import 'profile_screen.dart';
import 'tasks_screen.dart';
import 'location_screen.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _selectedIndex = 0;

  // Navigation methods
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    switch (index) {
      case 0:
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const PeopleScreen())
        );
        break;
      case 1:
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const CallScreen())
        );
        break;
      case 2:
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const ProfileScreen())
        );
        break;
      case 3:
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const LocationScreen())
        );
        break;
      case 4:
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const TasksScreen())
        );
        break;
    }
  }

  void _onProfileTapped() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const ProfileScreen())
    );
  }

  void _onMenuTapped() {
    _showSnackBar('Menu Opened');
    // Show drawer or menu
    // Scaffold.of(context).openDrawer();
  }

  void _onLeadTapped(String leadName) {
    _showSnackBar('Opening $leadName details');
    // Navigator.push(context, MaterialPageRoute(builder: (context) => LeadDetailScreen(leadName: leadName)));
  }

  void _onStatCardTapped(String statType, String value) {
    _showSnackBar('$statType: $value items');
    // Navigator.push(context, MaterialPageRoute(builder: (context) => StatDetailScreen(type: statType)));
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.grey[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF374151), // gray-700
              Color(0xFF111827), // gray-900
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _onMenuTapped,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _onProfileTapped,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Welcome Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Welcome, Alex !',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Rh 10:10 mn 17th Ah',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Stats Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: [
                    _buildStatCard('41', 'Leads'),
                    _buildStatCard('14', 'Follow-Ups'),
                    _buildStatCard('17', 'Messages'),
                    _buildStatCard('8', 'Tasks'),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Leads Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Leads',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView(
                          children: [
                            _buildLeadItem('James Smith', 'James Smith'),
                            _buildLeadItem('Oliva Taylor', 'Oliva Taylor'),
                            _buildLeadItem('Jaden Smith', 'Jaden Smith'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Navigation
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, Icons.people, true),
                    _buildNavItem(1, Icons.phone, false),
                    _buildNavItem(2, Icons.person, true),
                    _buildNavItem(3, Icons.my_location, false),
                    _buildNavItem(4, Icons.work, false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return GestureDetector(
      onTap: () => _onStatCardTapped(label, value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadItem(String name, String subtitle) {
    return GestureDetector(
      onTap: () => _onLeadTapped(name),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.person,
                color: Colors.grey[600],
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[600],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, bool hasContainer) {
    bool isSelected = _selectedIndex == index;
    
    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: hasContainer
          ? Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue[600] : Colors.grey[600],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            )
          : Icon(
              icon,
              color: isSelected ? Colors.blue[400] : Colors.grey[400],
              size: 24,
            ),
    );
  }
}