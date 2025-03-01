/// Quote Detail Screen
///
/// Displays a single quote with extended information including:
/// - Author image and name
/// - Full quote text
/// - Biographical information about the author
/// - Historical context for the quote
/// - Related quotes in the same category
///
/// The screen uses a rich visual layout with the deep purple theme consistent
/// with the rest of the application, and provides navigation back to the quotes list.
import 'package:flutter/material.dart';
import 'quote_item.dart';

/// Detail screen widget for displaying comprehensive information about a specific quote.
///
/// Presents an immersive view of a selected quote with the author's biography,
/// quote history, and related quotes from the same category. The screen maintains
/// the app's visual identity with deep purple background and custom styling.
/// Includes a back button for navigation to the previous screen.
class QuoteDetailScreen extends StatelessWidget {
  final QuoteItem quoteItem;

  const QuoteDetailScreen({
    Key? key,
    required this.quoteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1135),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Quote Details', style: TextStyle(color: Colors.white)),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            padding: EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 2.0), // Significantly reduced padding
            height: 20, // Explicitly set a small height
            decoration: BoxDecoration(
              color: getCategoryColor(quoteItem.category),
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Text(
              quoteItem.category,
              style: TextStyle(
                color: Colors.white,
                fontSize: 9, // Even smaller font size
                fontWeight: FontWeight.w500, // Slightly reduced weight
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author image and name
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(quoteItem.imagePath),
                  ),
                  SizedBox(height: 16),
                  Text(
                    quoteItem.author,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            // Quote
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '"${quoteItem.quote}"',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 32),

            // Additional information about the author (placeholder)
            Text(
              'About the Author',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              getAuthorBio(quoteItem.author),
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            SizedBox(height: 24),

            // Quote history (placeholder)
            Text(
              'Quote History',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'This quote has inspired many people over the years and continues to be shared as a reminder of the wisdom and perspective that comes with age and experience.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            SizedBox(height: 24),

            // More quotes from same category
            Text(
              'More ${quoteItem.category} Quotes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Show a few related quotes
                itemBuilder: (context, index) {
                  return Container(
                    width: 250,
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: getCategoryColor(quoteItem.category),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      "Life isn't about finding yourself. Life is about creating yourself.",
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns biographical information for a given author name.
  ///
  /// Contains information about notable authors featured in the app,
  /// including their birth/death years and major contributions.
  /// Returns a default message if the author is not in the predefined list.
  String getAuthorBio(String author) {
    // Simplified example - in a real app, you'd have this data in your model
    switch (author) {
      case "Abraham H. Maslow":
        return "Abraham Harold Maslow (1908-1970) was an American psychologist who created Maslow's hierarchy of needs, a theory of psychological health predicated on fulfilling innate human needs in priority.";
      case "Jules Renard":
        return "Jules Renard (1864-1910) was a French author and member of the Académie Goncourt, known for his poignant works on the struggles of provincial life.";
      case "Jiddu Krishnamurti":
        return "Jiddu Krishnamurti (1895-1986) was an Indian philosopher, speaker and writer who spoke of the need for a revolution in the psyche of every human being and emphasized the need for a change in consciousness.";
      case "Mark Twain":
        return "Mark Twain (1835-1910), whose real name was Samuel Clemens, was an American writer, humorist, and lecturer known for his novels including 'The Adventures of Tom Sawyer' and 'Adventures of Huckleberry Finn'.";
      case "Maya Angelou":
        return "Maya Angelou (1928-2014) was an American poet, memoirist, and civil rights activist best known for her series of seven autobiographies, which focus on her childhood and early adult experiences.";
      case "Albert Einstein":
        return "Albert Einstein (1879-1955) was a German-born theoretical physicist who developed the theory of relativity, one of the two pillars of modern physics. His work is also known for its influence on the philosophy of science.";
      case "Nelson Mandela":
        return "Nelson Mandela (1918-2013) was a South African anti-apartheid revolutionary, political leader and philanthropist who served as President of South Africa from 1994 to 1999, the country's first black head of state.";
      case "Steve Jobs":
        return "Steve Jobs (1955-2011) was an American entrepreneur, inventor, and business magnate who co-founded Apple Inc. and played a key role in revolutionizing the technology industry. As Apple's CEO, he led the development of groundbreaking products like the iPhone, iPad, and Mac, shaping the modern digital era.";
      case "Walt Disney":
        return "Walt Disney (1901-1966) was an American animator, film producer, and entrepreneur who co-founded The Walt Disney Company. A pioneer of the animation industry, he created iconic characters like Mickey Mouse and revolutionized entertainment with films like *Snow White and the Seven Dwarfs* and Disneyland, shaping the world of animation and theme parks.";
      case "Confucius":
        return "Confucius (551-479 BCE) was a Chinese philosopher, teacher, and political thinker whose ideas laid the foundation for Confucianism. Emphasizing morality, social harmony, and virtue, his teachings influenced East Asian culture, ethics, and governance for centuries, shaping philosophical and educational traditions worldwide.";
      case "Oscar Wilde":
        return "Oscar Wilde (1854-1900) was an Irish poet, playwright, and novelist known for his wit, flamboyant style, and sharp social commentary. A leading figure of the Aesthetic Movement, he wrote classics like *The Picture of Dorian Gray* and *The Importance of Being Earnest*, leaving a lasting impact on literature and drama.";
      case "Eleanor Roosevelt":
        return "Eleanor Roosevelt (1884-1962) was an American diplomat, activist, and First Lady of the United States from 1933 to 1945. A champion of human rights, she played a key role in drafting the Universal Declaration of Human Rights and redefined the role of First Lady through her advocacy for social justice, civil rights, and women's empowerment.";
      case "Aristotle":
        return "Aristotle (384-322 BCE) was an ancient Greek philosopher and polymath who made lasting contributions to many fields, including philosophy, science, ethics, and politics. A student of Plato and teacher of Alexander the Great, his works on logic, metaphysics, and ethics laid the foundation for Western philosophy and continue to influence various disciplines today.";
      case "Henry Ford":
        return "Henry Ford (1863-1947) was an American industrialist and founder of the Ford Motor Company. He revolutionized manufacturing by introducing the assembly line technique, making automobiles affordable and accessible to the masses. His innovations transformed the automotive industry and had a profound impact on modern industrial practices.";
      case "Thomas Edison":
        return "Thomas Edison (1847-1931) was an American inventor and businessman best known for developing the electric light bulb, phonograph, and motion pictures. Holding over 1,000 patents, his innovations greatly influenced the development of modern technology, shaping industries like electric power, communications, and entertainment.";
      default:
        return "Information about this author is not available.";
    }
  }

  /// Returns a color for the given quote category.
  ///
  /// Currently uses a consistent teal blue color for all categories,
  /// but could be extended to provide unique colors for different categories.
  Color getCategoryColor(String category) {
    // Return the same base color for all categories
    return Color(0xFF39A0ED); // Teal blue for all categories
  }
}
