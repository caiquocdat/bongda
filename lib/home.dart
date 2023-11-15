import 'package:bongda/page/GiaiDauScreen.dart';
import 'package:bongda/page/HomeScreen.dart';
import 'package:bongda/page/TrucTiepScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<home> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    GiaiDauScreen(),
    TrucTiepScreen()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = TrucTiepScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(child: currentScreen, bucket: bucket),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          'assets/img_home.png',
          width: 70.0,
          height: 70.0,
        ),
        onPressed: () {
          setState(() {
            currentScreen = HomeScreen();
            currentTab = 3;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        color:Color.fromARGB(255, 34, 34, 32),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Left Home Button
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(left: 30), // Add left margin here
                  child: MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = TrucTiepScreen();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img_live.png',
                            width: 30,
                            height: 30,
                            color: currentTab==0? Colors.white:Colors.grey,
                          ),
                          SizedBox(height: 5), // thêm khoảng cách
                          Text(
                              'Trực tiếp',
                              style: TextStyle(
                                  color: currentTab==0?Colors.white:Colors.grey
                              )
                          )
                        ],
                      ))
                ),
              ]),

              // Right Home Button
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(right: 30), // Add right margin here
                  child: MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = GiaiDauScreen();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img_giaidau.png',
                            width: 30,
                            height: 30,
                            color: currentTab==1? Colors.white:Colors.grey,
                          ),
                          SizedBox(height: 5), // thêm khoảng cách
                          Text(
                              'Giải đấu',
                              style: TextStyle(
                                  color: currentTab==1?Colors.white:Colors.grey
                              )
                          )
                        ],
                      ))
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
