import 'package:flutter/material.dart';
import 'package:girman_search_app/data/provider/user_provider.dart';
import 'package:girman_search_app/widgets/common_appbar.dart';
import 'package:girman_search_app/widgets/user_card.dart';
import 'package:provider/provider.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProvider>(context).filteredUsers;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(),
      body: CustomScrollView(
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
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                      ),
                      onChanged: (query) {
                        Provider.of<UserProvider>(context, listen: false)
                            .setSearchQuery(query);
                      },
                    ),
                  ),
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
    );
  }
}
