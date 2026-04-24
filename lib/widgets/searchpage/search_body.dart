import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBody();
}

class _SearchBody extends State<SearchBody> {
  Widget build(BuildContext context) {
    return SingleChildScrollView(child:Column(children: [Container(
      child: Row(
        children: [Container(
          margin: EdgeInsets.only(top: 10),
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(image: AssetImage('assets/images/test.jpg'),
            fit: BoxFit.cover)
          ),
        ), Container(
          height: 100,
          margin: EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Container(
              child: Text("제1열람실", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
            ),Container(child: Row(children: [Text("보통", style: TextStyle(color: greenLightColor),), 
            Container(margin: EdgeInsets.only(left: 30), child: Text("06:00 ~ 22:00")), 
            Container(margin: EdgeInsets.only(left: 30), child: Icon(Icons.chevron_right))])),Container(child: Text("804석/ 콘센트, 조용"))]
          ),
        )],
      ),
    )]));
  }
}