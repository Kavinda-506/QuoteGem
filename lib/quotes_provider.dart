/// Quotes Provider
///
/// State management class that handles all quote-related operations including:
/// - Maintaining the complete quote collection
/// - Filtering quotes by category, search terms, or favorites
/// - Managing user favorites with persistence via SharedPreferences
/// - Providing random quote selections
/// - Finding related quotes by category
///
/// Implements the ChangeNotifier pattern for reactive UI updates when the
/// quote data or selection criteria change.
import 'package:flutter/foundation.dart';
import 'dart:math' show Random;
import 'package:shared_preferences/shared_preferences.dart';
import 'quote_item.dart';

/// Provider class for managing quotes state
class QuotesProvider with ChangeNotifier {
  /// Complete collection of all available quotes in the application
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

  /// Currently displayed quotes in the UI based on filter criteria
  List<QuoteItem> _displayedQuotes = [];

  /// Getter method for accessing currently displayed quotes
  List<QuoteItem> get displayedQuotes => _displayedQuotes;

  /// Set of user's favorite quotes (stored using their unique ID)
  Set<String> _favoriteQuotes = {};

  /// Flag indicating whether we are currently showing only favorite quotes
  bool _showingFavorites = false;

  /// Getter for the favorites filter status
  bool get showingFavorites => _showingFavorites;

  /// Constructor that initializes the provider and loads saved favorites
  QuotesProvider() {
    _loadFavorites();
  }

  /// Loads the user's favorite quotes from SharedPreferences
  /// This is called during initialization to restore saved preferences
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favoriteQuotes') ?? [];
    _favoriteQuotes = Set<String>.from(favorites);
    notifyListeners();
  }

  /// Persists the user's favorite quotes to SharedPreferences
  /// Called whenever the favorites collection is modified
  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favoriteQuotes', _favoriteQuotes.toList());
  }

  /// Checks if a specific quote is marked as a favorite
  /// Returns true if the quote is a favorite, false otherwise
  bool isQuoteFavorite(QuoteItem quote) {
    String quoteId = _getQuoteId(quote);
    return _favoriteQuotes.contains(quoteId);
  }

  /// Generates a unique identifier for a quote by combining author and text
  /// Used for tracking favorites and ensuring uniqueness
  String _getQuoteId(QuoteItem quote) {
    return '${quote.author}:${quote.quote}';
  }

  /// Toggles the favorite status of a quote
  /// If the quote is already a favorite, it will be removed
  /// If the quote is not a favorite, it will be added
  void toggleFavorite(QuoteItem quote) {
    String quoteId = _getQuoteId(quote);

    if (_favoriteQuotes.contains(quoteId)) {
      _favoriteQuotes.remove(quoteId);
    } else {
      _favoriteQuotes.add(quoteId);
    }

    _saveFavorites();

    // If we're viewing favorites, we need to update the displayed quotes
    if (_showingFavorites) {
      _filterFavorites();
    }

    notifyListeners();
  }

  /// Sets the state of the favorites filter
  /// When true, only favorite quotes will be displayed
  void setShowingFavorites(bool value) {
    if (_showingFavorites != value) {
      _showingFavorites = value;
      notifyListeners();
    }
  }

  /// Updates displayed quotes to show only those marked as favorites
  /// Called when the favorites filter is activated
  void _filterFavorites() {
    if (_showingFavorites) {
      _displayedQuotes =
          allQuotes.where((quote) => isQuoteFavorite(quote)).toList();
    }
  }

  /// Filters quotes based on category and search query
  /// When favorites mode is active, only searches within favorites
  /// Otherwise, limits to 4 random quotes when no search is active
  void filterQuotes(String? category, String searchQuery) {
    if (_showingFavorites) {
      // Filter favorites
      _displayedQuotes = allQuotes
          .where((quote) =>
              isQuoteFavorite(quote) &&
              (category == null ||
                  category == 'All' ||
                  quote.category == category) &&
              (searchQuery.isEmpty ||
                  quote.quote
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  quote.author
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase())))
          .toList();
    } else {
      // Filter all quotes
      _displayedQuotes = allQuotes
          .where((quote) =>
              (category == null ||
                  category == 'All' ||
                  quote.category == category) &&
              (searchQuery.isEmpty ||
                  quote.quote
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  quote.author
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase())))
          .toList();

      // Limit to 4 quotes when not explicitly searching
      if (searchQuery.isEmpty) {
        final random = Random();
        _displayedQuotes.shuffle(random);
        if (_displayedQuotes.length > 4) {
          _displayedQuotes = _displayedQuotes.sublist(0, 4);
        }
      }
    }

    notifyListeners();
  }

  /// Refreshes the displayed quotes with a new random selection
  /// Respects the current category filter if one is active
  /// Does not affect favorites when in favorites mode
  void refreshQuotes(String? category) {
    if (_showingFavorites) {
      _filterFavorites();
    } else {
      final random = Random();

      // Filter by selected category (if not 'All')
      List<QuoteItem> filteredQuotes = List<QuoteItem>.from(allQuotes);

      if (category != null && category != 'All') {
        filteredQuotes = filteredQuotes
            .where((quote) => quote.category == category)
            .toList();
      }

      // Shuffle the quotes
      filteredQuotes.shuffle(random);

      // Take the first 4 quotes or less if there aren't enough
      _displayedQuotes = filteredQuotes.take(4).toList();
    }

    notifyListeners();
  }

  /// Finds quotes related to a specific quote by matching category
  /// Used on detail screens to show similar quotes
  /// Returns up to [count] quotes from the same category
  List<QuoteItem> getRelatedQuotes(QuoteItem currentQuote, int count) {
    List<QuoteItem> related = allQuotes
        .where((quote) =>
            quote.category == currentQuote.category && quote != currentQuote)
        .toList();

    if (related.isEmpty) return [];

    // Shuffle and limit
    related.shuffle();
    return related.take(count).toList();
  }
}
