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
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(children: [SearchHeader(), SearchBody()]),
          ),
        ),
      ),
    );
  }
}
