/// Quote Item Model
///
/// Defines the data structure for quotes within the application.
/// Each quote contains:
/// - author: The person who said or wrote the quote
/// - quote: The actual text of the quote
/// - imagePath: Location of the author's image asset
/// - category: The thematic category the quote belongs to (Motivational, Life, Wisdom, etc.)
///
/// This model is used throughout the app to maintain consistent quote representation.

/// Data model class for a quote item
///
/// Represents a single quote with its associated metadata including author,
/// content, image path, and thematic category. Used as the primary data structure
/// throughout the application for displaying and manipulating quotes.
class QuoteItem {
  final String author;
  final String quote;
  final String imagePath;
  final String category;

  QuoteItem({
    required this.author,
    required this.quote,
    required this.imagePath,
    required this.category,
  });
}
