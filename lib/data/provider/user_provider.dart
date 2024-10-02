import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class UserProvider extends ChangeNotifier {
  List<dynamic> _users = [];
  List<dynamic> _filteredUsers = [];
  String _searchQuery = '';

  List<dynamic> get filteredUsers => _filteredUsers;

  UserProvider() {
    _loadUserData();
  }

  void _loadUserData() async {
    String data = await rootBundle.loadString('assets/json/user_list.json');
    _users = json.decode(data);
    _filterUsers();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _filterUsers();
  }

  void _filterUsers() {
    _filteredUsers = _users.where((user) {
      return user['first_name']
              .toString()
              .toLowerCase()
              .contains(_searchQuery) ||
          user['last_name'].toString().toLowerCase().contains(_searchQuery);
    }).toList();
    notifyListeners();
  }
}
