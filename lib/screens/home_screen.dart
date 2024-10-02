import 'package:flutter/material.dart';
import 'package:girman_search_app/screens/search_results_screen.dart';
import 'package:girman_search_app/widgets/common_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.31, 1], // 31% stop for the white color
            colors: [
              Color(0xFFFFFFFF), // White at the top
              Color(0xFFB1CBFF), // Light blue at the bottom
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Image positioned according to requirements
            Positioned(
              top: -28,
              left: -252,
              child: Opacity(
                opacity: 0.75, // Background image with reduced opacity
                child: Image.asset(
                  'assets/images/home_bg_img.png', // Your background image asset
                  width: 897,
                  height: 897,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 175), // Add spacing at the top
                  // Logo image at the top center
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/girman_logo.png',
                        height: 65),
                  ),
                  const SizedBox(height: 20),
                  // Search input
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                      ),
                      onSubmitted: (query) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchResultScreen(query: query),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
