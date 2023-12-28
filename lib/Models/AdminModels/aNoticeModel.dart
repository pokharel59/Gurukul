class NoticeModel{
  final String title;
  final String description;

  NoticeModel({required this.title, required this.description});

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'description': description,
    };
  }

  factory NoticeModel.fromMap(Map<String, dynamic> map){
    return NoticeModel(
        title: map['title'],
        description: map['description'],
    );
  }

}