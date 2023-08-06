class Quote
{
  final String quote;
  final String category;
  final String author;

  Quote({required this.category,required this.author,required this.quote});

  factory Quote.fromMap({required Map data})
  {
    return Quote(category: data['category'], author: data['author'], quote: data['quote']);
  }

}