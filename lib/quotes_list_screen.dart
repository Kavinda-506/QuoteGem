/// Quotes List Screen
///
/// Main screen of the application that displays a curated list of quotes.
/// Features include:
/// - Random selection of quotes that refreshes on demand
/// - Category filtering through a custom bottom sheet
/// - Search functionality
/// - Navigation to the author selection screen
/// - Quote cards with author image, name, quote text, and category tag
/// - Navigation to detailed quote view
///
/// The screen maintains the app's deep purple theme and provides an intuitive
/// user interface for discovering and exploring quotes.
import 'package:flutter/material.dart';
import 'dart:math' show Random;
import 'author_selection_screen.dart';
import 'quotes_details_screen.dart';
import 'quote_item.dart';

/// Screen that displays a list of quotes with their authors
class QuotesListScreen extends StatefulWidget {
  const QuotesListScreen({Key? key}) : super(key: key);

  @override
  _QuotesListScreenState createState() => _QuotesListScreenState();
}

/// State class for QuotesListScreen
///
/// Manages the state of the quotes list screen including:
/// - Currently selected category filter
/// - List of all available quotes
/// - Currently displayed quotes based on filters
/// - Quote refresh functionality
/// - UI layout and interactions
class _QuotesListScreenState extends State<QuotesListScreen> {
  // Add state variable for the selected category
  String? selectedCategory = 'All';

  // Full list of quotes to choose from
  final List<QuoteItem> allQuotes = [
    QuoteItem(
        author: "Abraham H. Maslow",
        quote: "What a man can be, he must be",
        imagePath: "assets/Maslow-bw.webp",
        category: "Motivational"),
    QuoteItem(
        author: "Jules Renard",
        quote:
            "We are all mortal until the first kiss and the second glass of wine.",
        imagePath: "assets/Jules_Renard_circa_1900.jpg",
        category: "Life"),
    QuoteItem(
        author: "Jiddu Krishnamurti",
        quote:
            "It is no measure of health to be well adjusted to a profoundly sick society.",
        imagePath: "assets/download.webp",
        category: "Wisdom"),
    QuoteItem(
        author: "Abraham H. Maslow",
        quote: "The best way to predict the future is to create it.",
        imagePath: "assets/Maslow-bw.webp",
        category: "Motivational"),
    QuoteItem(
        author: "Mark Twain",
        quote: "The secret of getting ahead is getting started.",
        imagePath: "assets/Mark-Twain-1907.webp",
        category: "Success"),
    QuoteItem(
        author: "Maya Angelou",
        quote:
            "I've learned that people will forget what you said, people will forget what you did, but people will never forget how you made them feel.",
        imagePath: "assets/angelou.jpg",
        category: "Wisdom"),
    QuoteItem(
        author: "Albert Einstein",
        quote:
            "Life is like riding a bicycle. To keep your balance, you must keep moving.",
        imagePath: "assets/einstein.jpg",
        category: "Life"),
    QuoteItem(
        author: "Nelson Mandela",
        quote: "It always seems impossible until it's done.",
        imagePath: "assets/Nelson_Mandela_1994.jpg",
        category: "Motivational"),
    QuoteItem(
      author: "Steve Jobs",
      quote: "The only way to do great work is to love what you do.",
      imagePath: "assets/Jobs_hero20110329.webp",
      category: "Success",
    ),
    QuoteItem(
      author: "Walt Disney",
      quote: "The way to get started is to quit talking and begin doing.",
      imagePath: "assets/Walt Disney.jpg",
      category: "Success",
    ),
    QuoteItem(
      author: "Confucius",
      quote: "It does not matter how slowly you go as long as you do not stop.",
      imagePath: "assets/confucius-chinese-school.jpg",
      category: "Motivational",
    ),
    QuoteItem(
      author: "Oscar Wilde",
      quote: "Be yourself; everyone else is already taken.",
      imagePath: "assets/oscar-wilde-20230212.jpg",
      category: "Life",
    ),
    QuoteItem(
      author: "Eleanor Roosevelt",
      quote:
          "The future belongs to those who believe in the beauty of their dreams.",
      imagePath: "assets/CT_74-53_(cropped).jpg",
      category: "Motivational",
    ),
    QuoteItem(
      author: "Aristotle",
      quote: "Knowing yourself is the beginning of all wisdom.",
      imagePath: "assets/Aristotle_Altemps_Inv8575.jpg",
      category: "Wisdom",
    ),
    QuoteItem(
      author: "Henry Ford",
      quote:
          "Whether you think you can, or you think you can't - you're right.",
      imagePath: "assets/Henry Ford.jpg",
      category: "Success",
    ),
    QuoteItem(
      author: "Thomas Edison",
      quote: "I have not failed. I've just found 10,000 ways that won't work.",
      imagePath: "assets/Thomas_Edison2.jpg",
      category: "Success",
    ),
  ];

  // Currently displayed quotes
  late List<QuoteItem> displayedQuotes;

  @override
  void initState() {
    super.initState();
    // Initialize with random quotes
    refreshQuotes();
  }

  /// Function to get random quotes
  ///
  /// Refreshes the displayed quotes list with a random selection from
  /// the full quote collection, filtered by the currently selected category.
  void refreshQuotes() {
    final random = Random();
    // Create a copy of allQuotes to avoid modifying the original
    List<QuoteItem> filteredQuotes = List<QuoteItem>.from(allQuotes);

    // Filter by selected category (if not 'All')
    if (selectedCategory != null && selectedCategory != 'All') {
      filteredQuotes = filteredQuotes
          .where((quote) => quote.category == selectedCategory)
          .toList();
    }

    // Shuffle the quotes
    filteredQuotes.shuffle(random);

    // Take the first 4 quotes or less if there aren't enough
    setState(() {
      displayedQuotes = filteredQuotes.take(4).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1135), // Deep purple background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Top bar with back button, title, and refresh button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      // Since this is the home screen, back button could be disabled
                      // or could go back to splash for demonstration
                    },
                  ),
                  Text(
                    'Daily Quotes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh, color: Colors.white),
                    onPressed: () {
                      // Refresh quotes with new random selection
                      refreshQuotes();

                      // Show feedback to user
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Quotes refreshed!')));
                    },
                  ),
                ],
              ),

              // Search bar (full width)
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFFD8ECF0),
                      Color(0xFFB0C9CE),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black54),
                    icon: Icon(Icons.search, color: Colors.black54),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.black87),
                ),
              ),

              // Row for Category dropdown and Browse Authors button (50-50 split)
              Row(
                children: [
                  // Category dropdown (50%)
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(right: 8.0, bottom: 16.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFD8ECF0),
                            Color(0xFFB0C9CE),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          onTap: () {
                            // Show a more user-friendly bottom sheet for category selection
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFF2D1F4A), // Slightly lighter than background
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: 40,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          'Select Category',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                          color: Colors.white.withOpacity(0.1)),
                                      Expanded(
                                        child: ListView(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          children: <String>[
                                            'All',
                                            'Motivational',
                                            'Wisdom',
                                            'Success',
                                            'Life',
                                            'Happiness'
                                          ].map((String value) {
                                            bool isSelected =
                                                selectedCategory == value;
                                            return ListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 24),
                                              leading: Icon(
                                                isSelected
                                                    ? Icons.check_circle
                                                    : Icons.circle_outlined,
                                                color: isSelected
                                                    ? Color(0xFF39A0ED)
                                                    : Colors.white70,
                                              ),
                                              title: Text(
                                                value,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: isSelected
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  selectedCategory = value;
                                                  refreshQuotes(); // Refresh with selected category
                                                });
                                                Navigator.pop(context);
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              children: [
                                // Place the text on the left with some padding
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    selectedCategory ?? 'Select Category',
                                    style: TextStyle(
                                      color: Colors
                                          .black54, // Same color as "Search" placeholder
                                      fontSize: 14,
                                      fontWeight: FontWeight
                                          .w600, // A bit bolder but not too bold
                                    ),
                                  ),
                                ),
                                // Push the icon to the right edge
                                Spacer(),
                                // Keep only the dropdown/arrow icon
                                Icon(Icons.arrow_drop_down,
                                    color: Colors.black54),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Browse Authors Button (50%)
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 8.0, bottom: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to author selection screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthorSelectionScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Browse Authors',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Section title
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    selectedCategory == 'All'
                        ? 'Today\'s Quotes'
                        : '$selectedCategory Quotes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Quotes list
              Expanded(
                child: displayedQuotes.isEmpty
                    ? Center(
                        child: Text(
                          'No quotes found in this category',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: displayedQuotes.length,
                        itemBuilder: (context, index) {
                          return QuoteCard(
                            quoteItem: displayedQuotes[index],
                            onTap: () {
                              // Navigate to detail screen when a quote is tapped
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuoteDetailScreen(
                                          quoteItem: displayedQuotes[index])));
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card widget to display individual quote items
///
/// Features:
/// - Displays author image on the left side
/// - Shows author name and quote text in the main area
/// - Shows category tag in the top right corner
/// - Supports tap interaction to navigate to detail view
/// - Consistent styling with the app's dark theme
class QuoteCard extends StatelessWidget {
  final QuoteItem quoteItem;
  final VoidCallback onTap;

  const QuoteCard({
    Key? key,
    required this.quoteItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Row(
          children: [
            // Author image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
              ),
              child: Image.asset(
                quoteItem.imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),

            // Author name and quote
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            quoteItem.author,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: getCategoryColor(quoteItem.category),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            quoteItem.category,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '"${quoteItem.quote}"',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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

  /// Helper function to get category color
  ///
  /// Returns a consistent color for all categories to maintain
  /// visual harmony across the app.
  ///
  /// @param category The quote category name
  /// @return Color The color to use for the category tag
  Color getCategoryColor(String category) {
    // Return the same base color for all categories
    return Color(0xFF39A0ED); // Teal blue for all categories
  }
}
