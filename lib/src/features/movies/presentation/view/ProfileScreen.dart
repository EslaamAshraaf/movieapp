import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  static const String routeName = "Profile";

  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFF121312),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 3,
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.white,
          backgroundColor: Color(0xFF282A28),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("icons/home.png")),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("icons/search.png")),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("icons/bookmark.png")),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("icons/person.png")),
              label: "",
            ),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                color: Color(0xFF212121),
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset("images/gamer (1).png",fit: BoxFit.cover,),
                          Text(
                            "12",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "10",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "John Safwat",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Wish List",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "History",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  backgroundColor: Color(0xFFF6BD00),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    color: Color(0xFF121312),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  backgroundColor: const Color(0xFFE82626),
                                ),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Exit",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(Icons.exit_to_app, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      TabBar(
                        unselectedLabelColor: Colors.yellow,
                        unselectedLabelStyle: TextStyle(
                          color: Colors.white,
                        ),

                        indicatorColor: Colors.yellow,
                        indicatorWeight: 4,
                        dividerColor: Color(0xFF202020),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,

                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        tabs: [
                          Tab(
                            icon: Icon(Icons.list, color: Colors.yellow, size: 35),
                            text: "Watch List",
                          ),
                          Tab(
                            icon: Icon(
                              Icons.folder,
                              color: Colors.yellow,
                              size: 35,
                            ),
                            text: "History",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color(0xFF121312),
                child: const TabBarView(
                  children: [
                    Center(
                      child: Image(image: AssetImage("images/Empty 1.png")),
                    ),
                    Center(
                      child: Image(image: AssetImage("images/Empty 1.png")),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
