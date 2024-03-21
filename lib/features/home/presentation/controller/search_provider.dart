import 'package:flutter/foundation.dart';

class SearchProvider extends ChangeNotifier {
  String _searchKey = "";

  void setSearchKey(String searchKey) {
    _searchKey = searchKey.toLowerCase();
    notifyListeners();
  }

  String getSearchKey() {
    return _searchKey;
  }
}
