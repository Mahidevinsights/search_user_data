import 'package:flutter/material.dart';
import 'package:girman_search_app/data/provider/user_provider.dart';
import 'package:girman_search_app/screens/search_results_screen.dart';
import 'package:girman_search_app/widgets/common_appbar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen height and width
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final double verticalPadding = screenHeight * 0.05; // 5% vertical padding

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
              padding: EdgeInsets.symmetric(
                  horizontal:
                      screenWidth * 0.07), // Responsive horizontal padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height:
                          verticalPadding * 3.5), // Dynamic spacing at the top

                  // Logo image
                  Image.asset('assets/images/girman_logo.png', height: 65),

                  SizedBox(height: verticalPadding), // Vertical padding

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
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                      ),
                      onSubmitted: (query) {
                        Provider.of<UserProvider>(context, listen: false)
                            .setSearchQuery(query);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchResultScreen(initialQuery: query),
                          ),
                        );

                        _searchController.clear();
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
