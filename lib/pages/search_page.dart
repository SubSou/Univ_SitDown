import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/widgets/searchpage/search_header.dart';
import 'package:sitdown/widgets/searchpage/search_body.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<SearchPage> {
  String? selectedCategory;
  String? keyword;

  void handleSearch({String? category, String? searchKeyword}) {
    setState(() {
      selectedCategory = category;
      keyword = searchKeyword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SearchHeader(onSearch: handleSearch),
              const SizedBox(height: 10),
              Expanded(
                child: SearchBody(category: selectedCategory, keyword: keyword),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
