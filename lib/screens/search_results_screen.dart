import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:girman_search_app/widgets/common_appbar.dart';
import 'package:girman_search_app/widgets/user_card.dart';

class SearchResultScreen extends StatefulWidget {
  final String query;

  const SearchResultScreen({super.key, required this.query});

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<dynamic> users = [];
  List<dynamic> filteredUsers = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.query;
    _loadUserData();
  }

  void _loadUserData() async {
    String data = await rootBundle.loadString('assets/json/user_list.json');
    setState(() {
      users = json.decode(data);
      _filterUsers();
    });
  }

  void _filterUsers() {
    setState(() {
      filteredUsers = users.where((user) {
        return user['first_name']
                .toString()
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            user['last_name']
                .toString()
                .toLowerCase()
                .contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend body behind the AppBar
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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34.0),
                child: Column(
                  children: [
                    // Search input at the top
                    Container(
                      margin: const EdgeInsets.only(top: 100, bottom: 20),
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
                        onChanged: (query) =>
                            _filterUsers(), // Refilter on text change
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            filteredUsers.isNotEmpty
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var user = filteredUsers[index];
                        return UserCard(user: user);
                      },
                      childCount: filteredUsers.length,
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/empty_search.png',
                              height: 300,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
