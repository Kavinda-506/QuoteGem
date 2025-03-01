import 'package:flutter/material.dart';

/// Screen that displays a grid of authors to browse
class AuthorSelectionScreen extends StatelessWidget {
  const AuthorSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get all unique authors from the list (assuming you have access to the same quote list)
    // This is used to extract unique authors from your existing quotes list
    List<AuthorInfo> authors = [
      AuthorInfo(
        name: "Abraham H. Maslow",
        imagePath: "assets/Maslow-bw.webp",
        backgroundImagePath:
            "assets/3c1a6e5c04b046a5f05fea70cdf1a0f5.jpg", // You'll need these background images
      ),
      AuthorInfo(
        name: "Renard",
        imagePath: "assets/Jules_Renard_circa_1900.jpg",
        backgroundImagePath: "assets/48e552ba9d4852db730ed4922d19c328.jpg",
      ),
      AuthorInfo(
        name: "Jiddu Krishnamurti",
        imagePath: "assets/download.webp",
        backgroundImagePath: "assets/a1dcdb6a51ad3a03799c60f648837946.jpg",
      ),
      AuthorInfo(
        name: "Mark Twain",
        imagePath: "assets/Mark-Twain-1907.webp",
        backgroundImagePath: "assets/unsplash_wzkv5p5CIRk.png",
      ),
      AuthorInfo(
        name: "Maya Angelou",
        imagePath: "assets/angelou.jpg",
        backgroundImagePath: "assets/48e552ba9d4852db730ed4922d19c328.jpg",
      ),
      AuthorInfo(
        name: "Albert Einstein",
        imagePath: "assets/einstein.jpg",
        backgroundImagePath: "assets/a1dcdb6a51ad3a03799c60f648837946.jpg",
      ),
      AuthorInfo(
        name: "Nelson Mandela",
        imagePath: "assets/Nelson_Mandela_1994.jpg",
        backgroundImagePath: "assets/unsplash_wzkv5p5CIRk.png",
      ),
      AuthorInfo(
        name: "Steve Jobs",
        imagePath: "assets/Jobs_hero20110329.webp",
        backgroundImagePath: "assets/author_bg_8.jpg",
      ),
      AuthorInfo(
        name: "Walt Disney",
        imagePath: "assets/Walt Disney.jpg",
        backgroundImagePath: "assets/author_bg_9.jpg",
      ),
      AuthorInfo(
        name: "Confucius",
        imagePath: "assets/confucius-chinese-school.jpg",
        backgroundImagePath: "assets/author_bg_10.jpg",
      ),
      AuthorInfo(
        name: "Oscar Wilde",
        imagePath: "assets/oscar-wilde-20230212.jpg",
        backgroundImagePath: "assets/author_bg_11.jpg",
      ),
      AuthorInfo(
        name: "Eleanor Roosevelt",
        imagePath: "assets/CT_74-53_(cropped).jpg",
        backgroundImagePath: "assets/author_bg_12.jpg",
      ),
      AuthorInfo(
        name: "Aristotle",
        imagePath: "assets/Aristotle_Altemps_Inv8575.jpg",
        backgroundImagePath:
            "assets/author_bg_1.jpg", // Reusing backgrounds is fine
      ),
      AuthorInfo(
        name: "Henry Ford",
        imagePath: "assets/Henry Ford.jpg",
        backgroundImagePath: "assets/author_bg_2.jpg",
      ),
      AuthorInfo(
        name: "Thomas Edison",
        imagePath: "assets/Thomas_Edison2.jpg",
        backgroundImagePath: "assets/author_bg_3.jpg",
      ),
    ];

    return Scaffold(
      backgroundColor:
          Color(0xFF1D1135), // Deep purple background matching your app
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Browse Authors', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: authors.length,
          itemBuilder: (context, index) {
            return AuthorCard(
              authorInfo: authors[index],
              onTap: () {
                // Navigate to a screen showing all quotes by this author
                // You can create this screen later
                _showAuthorQuotes(context, authors[index]);
              },
            );
          },
        ),
      ),
    );
  }

  void _showAuthorQuotes(BuildContext context, AuthorInfo authorInfo) {
    // For now, we'll just show a snackbar
    // Later you can implement an actual screen to show quotes by this author
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Showing quotes by ${authorInfo.name}'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

/// Card widget to display author information
class AuthorCard extends StatelessWidget {
  final AuthorInfo authorInfo;
  final VoidCallback onTap;

  const AuthorCard({
    Key? key,
    required this.authorInfo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: EdgeInsets.only(bottom: 24.0),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            // Card with background image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Stack(
                  children: [
                    // Since you might not have the specific background images shown in your design,
                    // I'll create a gradient with varying colors for each author until you add them
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            _getRandomColor(authorInfo.name),
                            _getComplementaryColor(authorInfo.name),
                          ],
                        ),
                      ),
                    ),

                    // White bottom section for author name
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0),
                          ),
                        ),
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          authorInfo.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Author Image (Centered at bottom of card, partly overlapping)
            Positioned(
              bottom: 35, // Position to overlap the white section
              left: 0,
              right: 0,
              child: Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 38,
                    backgroundImage: AssetImage(authorInfo.imagePath),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Generate visually appealing random colors based on author name
  Color _getRandomColor(String name) {
    int hash = name.hashCode;

    // Map to a pleasant range of hues (avoiding yellows and browns)
    double hue = (hash % 255) / 255 * 360;
    if (hue > 30 && hue < 60) hue = 30; // Avoid yellows
    if (hue > 60 && hue < 90) hue = 90; // Avoid mustards

    return HSLColor.fromAHSL(1.0, hue, 0.7, 0.5).toColor();
  }

  // Get a complementary color for gradients
  Color _getComplementaryColor(String name) {
    int hash = name.hashCode;
    double hue = ((hash % 255) / 255 * 360 + 180) % 360;
    return HSLColor.fromAHSL(1.0, hue, 0.8, 0.4).toColor();
  }
}

/// Data model for an author
class AuthorInfo {
  final String name;
  final String imagePath;
  final String backgroundImagePath;

  AuthorInfo({
    required this.name,
    required this.imagePath,
    required this.backgroundImagePath,
  });
}
