import 'package:flutter/material.dart';
import 'package:girman_search_app/data/provider/user_provider.dart';
import 'package:girman_search_app/widgets/common_appbar.dart';
import 'package:girman_search_app/widgets/user_card.dart';
import 'package:provider/provider.dart';

class SearchResultScreen extends StatefulWidget {
  final String initialQuery; // Accept search query from HomeScreen

  const SearchResultScreen({super.key, required this.initialQuery});

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    // Initialize the search controller with the initial query from HomeScreen
    _searchController = TextEditingController(text: widget.initialQuery);
    // Set the search query in UserProvider to filter users based on the initial query
    Provider.of<UserProvider>(context, listen: false)
        .setSearchQuery(widget.initialQuery);
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProvider>(context).filteredUsers;
    // Get the screen height and width for responsiveness
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final double verticalPadding = screenHeight * 0.05;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.31, 1],
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFB1CBFF),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -28,
              left: -252,
              child: Opacity(
                opacity: 0.75,
                child: Image.asset(
                  'assets/images/home_bg_img.png',
                  width: 897,
                  height: 897,
                ),
              ),
            ),
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    child: Column(
                      children: [
                        SizedBox(height: verticalPadding * 3),
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
                            controller:
                                _searchController, // Use the controller with the initial query
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.grey),
                            ),
                            onChanged: (query) {
                              Provider.of<UserProvider>(context, listen: false)
                                  .setSearchQuery(query);
                            },
                          ),
                        ),
                        SizedBox(height: verticalPadding * 0.7),
                      ],
                    ),
                  ),
                ),
                users.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            var user = users[index];
                            return UserCard(user: user);
                          },
                          childCount: users.length,
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: verticalPadding * 2),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/empty_search.png',
                                  height: screenHeight * 0.3,
                                ),
                              ],
                            ),
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
}
