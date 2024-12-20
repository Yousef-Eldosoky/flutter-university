import 'package:flutter/material.dart';
import 'package:university/business/auth_service.dart';
import 'package:university/pages/apply_now.dart';
import 'package:university/pages/courses.dart';
import 'package:university/pages/majors.dart';
import 'package:university/pages/account_page.dart';
import 'guidelines_page.dart';
import 'applicationstatus.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  
  final List<Map<String, dynamic>> gridItems = [
    {"title": "Courses", "image": "images/cor.jpg", "page": majors()},
    {"title": "My Application", "image": "images/app.jpg", "page": const ApplicationStatusPage()},
    {"title": "Apply Now", "image": "images/apply.jpg", "page": ApplicationForm()},
    {"title": "Majors", "image": "images/mj.jpg", "page": const courses()},
  ];

  final List<Widget> _pages = [
    _HomeContent(),
    const AccountPage(),
    const GuidelinesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.blueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/app.jpg',
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 40),
              const Text(
                'welcome to iaems   \n   \n       wish you all the best',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 70),
              const Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  await AuthService.logout();
                  Navigator.pushReplacementNamed(context, 'auth');
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Logout', style: TextStyle(color: Colors.red)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'FAQ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gridItems = [
      {"title": "Courses", "image": "images/cor.jpg", "page": majors()},
      {"title": "My Application", "image": "images/app.jpg", "page": const ApplicationStatusPage()},
      {"title": "Apply Now", "image": "images/apply.jpg", "page": ApplicationForm()},
      {"title": "Majors", "image": "images/mj.jpg", "page": const courses()},
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          AppBarWidget(),
          const Padding(
            padding: EdgeInsets.only(top: 5, left: 10, bottom: 0),
            child: Text(
              "let's start the journey....                                     ^ ",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 94, 131, 243),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 2.8,
              ),
              itemCount: gridItems.length,
              itemBuilder: (context, index) {
                final item = gridItems[index];
                return GestureDetector(
                  onTap: () {
                    if (item['page'] != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => item['page'] as Widget),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          item['image'] as String,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item['title'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! < 0) {
                Scaffold.of(context).openDrawer();
              }
            },
            child: Container(
              height: 50,
              width: 180,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 2,
                ),
              ),
              child: const Center(
                child: Text(
                  "swipe ^^ ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ApplicationStatus {
  const ApplicationStatus();
}

PageRouteBuilder _createPageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Slide from right
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      height: 180,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 53, 86, 167),
            Color.fromARGB(255, 94, 131, 243)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "IAEMS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Welcome to IAEMS!",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(0.1),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
