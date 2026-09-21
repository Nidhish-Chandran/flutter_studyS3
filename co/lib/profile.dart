import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isExpanded = false;
  bool isFollowing = false;

  void toggleProfile() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Animated Profile Image
              GestureDetector(
                onTap: toggleProfile,

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,

                  width: isExpanded ? 220 : 150,
                  height: isExpanded ? 220 : 150,

                  padding: const EdgeInsets.all(5),

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isExpanded
                          ? Colors.blue
                          : Colors.grey,
                      width: isExpanded ? 6 : 3,
                    ),
                  ),

                  child: ClipOval(
                    child: Image.network(
                      'https://i.pravatar.cc/400',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // User Name
              const Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              // Designation
              const Text(
                'Software Developer',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              // Additional Details
              AnimatedSize(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,

                child: isExpanded
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),

                        child: const Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'john.doe@gmail.com',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 15),

                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '+91 98765 43210',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              const SizedBox(height: 25),

              // Animated Follow Button
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,

                width: isFollowing ? 150 : 130,
                height: 50,

                child: ElevatedButton(
                  onPressed: toggleFollow,

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isFollowing ? Colors.green : Colors.blue,
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),

                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),

                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },

                    child: Text(
                      isFollowing ? 'Following' : 'Follow',
                      key: ValueKey(isFollowing),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                'Tap the profile image to view details',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}