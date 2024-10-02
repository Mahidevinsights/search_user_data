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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 175),
            Image.asset('assets/images/girman_logo.png', height: 65),
            const SizedBox(height: 20),
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
                  Provider.of<UserProvider>(context, listen: false)
                      .setSearchQuery(query);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchResultScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
