class NoticeModel{
  final String title;
  final String description;
  final String documentUrl;

  NoticeModel({required this.title, required this.description, required this.documentUrl});

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'description': description,
      'documentUrl': documentUrl
    };
  }

  factory NoticeModel.fromMap(Map<String, dynamic> map){
    return NoticeModel(
        title: map['title'],
        description: map['description'],
      documentUrl: map['documentUrl']
    );
  }

}