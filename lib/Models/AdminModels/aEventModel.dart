class EventModel{
  final String title;
  final String description;
  final int eventDate;
  final String location;
  final String eventStatus;

  EventModel({required this.title, required this.description, required this.eventDate, required this.location, required this.eventStatus});

  Map<String, dynamic> toMap(){
    return{
      'title':title,
      'description':description,
      'eventDate':eventDate,
      'location':location,
      'eventStatus':eventStatus
    };
  }

  factory EventModel.fromMap(Map<String, dynamic>map){
    return EventModel(
        title: map['title'],
        description: map['description'],
        eventDate: map['eventDate'],
        location: map['location'],
        eventStatus: map['eventStatus']
    );
  }
}