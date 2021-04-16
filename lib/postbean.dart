class Post {

  final int id;
  String title;
  String link;


  Post({this.id, this.title, this.link});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        title: json['title'].toString(),
        link: json['link'].toString()
    );
  }
}