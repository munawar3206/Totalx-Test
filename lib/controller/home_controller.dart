// home_provider.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProvider extends ChangeNotifier {
  late Stream<QuerySnapshot> _stream;
  late String _selectedAgeOption;
  late String _searchQuery;

  HomeProvider() {
    _selectedAgeOption = '';
    _searchQuery = '';
    _stream = FirebaseFirestore.instance.collection("Upload_Items").snapshots();
  }

  Stream<QuerySnapshot> get stream => _stream;

  String get selectedAgeOption => _selectedAgeOption;

  void setSelectedAgeOption(option) {
    _selectedAgeOption = option;
    notifyListeners();
  }

  String get searchQuery => _searchQuery;

  void setSearchQuery(query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Map> filterItems(List<Map> items) {
    if (searchQuery.isNotEmpty) {
      items = items
          .where((item) =>
              item['name']
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              item['age']
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    }

    if (selectedAgeOption == 'Elder') {
      items = items
          .where((item) => int.parse(item['age'].toString()) <= 40)
          .toList();
    } else if (selectedAgeOption == 'Younger') {
      items = items
          .where((item) => int.parse(item['age'].toString()) >= 41)
          .toList();
    }

    return items;
  }
}
