class ArticleModel{
  ArticleModel({required this.title, required this.image, required this.description});
  final String title;
  final String? image;
  final String? description;

  factory ArticleModel.fromJson(json){
    return ArticleModel(
        title: json['title'],
        image: json['urlToImage'],
        description: json['description']
    );
  }
}


