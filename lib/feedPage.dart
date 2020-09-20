import 'package:flutter/material.dart';
import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class Feed extends StatefulWidget {
  const Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    // ..addListener(() {
    // setState(() {
    // _tabController.index = 0;
    // });
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Color(0xFF181d3d),
        buttonBackgroundColor: Color(0xFFF49F1C),
        height: 60,
        animationDuration: Duration(
          milliseconds: 200,
        ),
        index: 0,
        //.. default start position for icon
        animationCurve: Curves.bounceInOut,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.notifications,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
          // Icon(          // extra icon in case of moderator and admin
          //   Icons.person,
          //   size: 30,
          //   color: Colors.white,
          // ),
        ],

        onTap: onItemTapped,
      ),
      key: _scaffoldState,
      drawer: NavDrawer(),
      body: Stack(
        children: [
          Container(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                    // add contents of the feed page
                    ),
                Container(
                    // add contents of the bookmark page
                    ),
              ],
            ),
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.035,
                      color: Color(0xFF181D3D),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ClipPath(
                          clipper: CurveClipper(),
                          child: Container(
                            //constraints: BoxConstraints.expand(),
                            color: Color(0xFF181D3D),
                          )),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 25.0),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //implementation of sidebar
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () {
                            _scaffoldState.currentState.openDrawer();
                          },
                        ),
                        SizedBox(
                          width: 35.0,
                        ),
                        Text(
                          'InstiComplaints',
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontFamily: 'Amaranth',
                          ),
                        ),
                        SizedBox(
                          width: 40.0,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    // Implementation of tabbar
                    Center(
                      child: Container(
                        width: 285.0,
                        child: TabBar(
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                            color: Color(0xFF606fad),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          tabs: [
                            Tab(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    40.0, 7.0, 40.0, 3.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.mode_comment,
                                      color: Colors.white,
                                      size: 18.0,
                                    ),
                                    SizedBox(
                                      height: 1.0,
                                    ),
                                    Text(
                                      'Feed',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    17.0, 7.0, 17.0, 3.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                      size: 18.0,
                                    ),
                                    SizedBox(
                                      height: 1.0,
                                    ),
                                    Text(
                                      'Bookmarks',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////

// code for the upper design of appbar

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      // set the "current point"
      ..addArc(Rect.fromLTWH(0, 0, size.width / 2, size.width / 3), pi, -1.57)
      ..lineTo(9 * size.width / 10, size.width / 3)
      ..addArc(
          Rect.fromLTWH(
              size.width / 2, size.width / 3, size.width / 2, size.width / 3),
          pi + 1.57,
          1.57)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.width / 6);
    return path;
  }

  @override
  bool shouldReclip(oldCliper) => false;
}

////////////////////////////////////////////////////////////////////////////////

// code for the sidebar

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  bool isSwitched1 = true;
  bool isSwitched2 = true;
  bool isSwitched3 = true;
  bool isSwitched4 = true;
  bool isSwitched5 = true;
  bool isSwitched6 = true;
  bool isSwitched7 = true;
  bool isSwitched8 = true;
  bool isSwitched9 = true;
  bool isSwitched10 = true;
  bool isSwitched11 = true;
  bool isSwitched12 = true;
  bool isSwitched13 = true;
  bool isSwitched14 = true;
  bool isSwitched15 = true;
  bool isSwitched16 = true;
  bool isSwitched17 = true;
  bool isSwitched18 = true;
  bool isSwitched19 = true;
  bool isSwitched20 = true;
  bool isSwitched21 = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/third');
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        color: Colors.black54,
                        spreadRadius: 0.9,
                      )
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 70.0,
                    backgroundImage: AssetImage("assets/profilePic.jpg"),
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage("assets/app_logo_final0.png"),
              //       fit: BoxFit.fitHeight,
              //     )),
            ),
            Center(
              child: Container(
                color: Color(0xFF181D3D),
                child: ListTile(
                  title: Center(
                    child: Text(
                      'Hi, Kenny ', // declare the variable for the name of user
                      style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'JosefinSans',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(2.0),
                children: [
                  ExpansionTile(
                    leading: Icon(
                      Icons.filter_list,
                      color: Color(0xFF181D3D),
                    ),
                    title: Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    children: [
                      ListTile(
                        leading: Switch(
                          value: isSwitched1,
                          onChanged: (value) {
                            setState(() {
                              isSwitched1 = value;
                              print(isSwitched1);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Administration'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched2,
                          onChanged: (value) {
                            setState(() {
                              isSwitched2 = value;
                              print(isSwitched2);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Gymkhana'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched3,
                          onChanged: (value) {
                            setState(() {
                              isSwitched3 = value;
                              print(isSwitched3);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('General'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched4,
                          onChanged: (value) {
                            setState(() {
                              isSwitched4 = value;
                              print(isSwitched4);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Campus'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched5,
                          onChanged: (value) {
                            setState(() {
                              isSwitched5 = value;
                              print(isSwitched5);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Proctor'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched6,
                          onChanged: (value) {
                            setState(() {
                              isSwitched6 = value;
                              print(isSwitched6);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('C. V. Raman'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched7,
                          onChanged: (value) {
                            setState(() {
                              isSwitched7 = value;
                              print('Hello');
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Morvi'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched8,
                          onChanged: (value) {
                            setState(() {
                              isSwitched8 = value;
                              print(isSwitched8);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Dhanrajgiri'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched9,
                          onChanged: (value) {
                            setState(() {
                              isSwitched9 = value;
                              print(isSwitched9);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Rajputana'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched10,
                          onChanged: (value) {
                            setState(() {
                              isSwitched10 = value;
                              print(isSwitched10);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Limbdi'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched11,
                          onChanged: (value) {
                            setState(() {
                              isSwitched11 = value;
                              print(isSwitched11);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Vivekanand'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched12,
                          onChanged: (value) {
                            setState(() {
                              isSwitched12 = value;
                              print(isSwitched12);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Vishwakarma'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched13,
                          onChanged: (value) {
                            setState(() {
                              isSwitched13 = value;
                              print(isSwitched13);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Vishweshvaraiya'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched14,
                          onChanged: (value) {
                            setState(() {
                              isSwitched14 = value;
                              print(isSwitched14);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Aryabhatt'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched15,
                          onChanged: (value) {
                            setState(() {
                              isSwitched15 = value;
                              print(isSwitched15);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('S.N.Bose'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched16,
                          onChanged: (value) {
                            setState(() {
                              isSwitched16 = value;
                              print(isSwitched16);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Dr. S. Ramanujan'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched17,
                          onChanged: (value) {
                            setState(() {
                              isSwitched17 = value;
                              print(isSwitched17);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Gandhi Smriti Chatravas (Old)'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched18,
                          onChanged: (value) {
                            setState(() {
                              isSwitched18 = value;
                              print(isSwitched18);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('Gandhi Smriti Chatravas(Extension)'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched19,
                          onChanged: (value) {
                            setState(() {
                              isSwitched19 = value;
                              print(isSwitched19);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('IIT Boys (Saluja)'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched20,
                          onChanged: (value) {
                            setState(() {
                              isSwitched20 = value;
                              print(isSwitched20);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('IIT(BHU) Girls'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched21,
                          onChanged: (value) {
                            setState(() {
                              isSwitched21 = value;
                              print(isSwitched21);
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: Text('S. C. Dey'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 0.5,
              color: Color(0xFF181D3D),
              thickness: 0.5,
              indent: 15.0,
              endIndent: 15.0,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Color(0xFF181D3D),
              ),
              title: Text('About'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            Divider(
              height: 0.5,
              color: Color(0xFF181D3D),
              thickness: 0.5,
              indent: 15.0,
              endIndent: 15.0,
            ),
            ListTile(
              leading: Icon(
                Icons.reply,
                color: Color(0xFF181D3D),
              ),
              title: Text('Log Out'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            Divider(
              height: 0.75,
              color: Color(0xFF181D3D),
              thickness: 0.75,
              indent: 15.0,
              endIndent: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}