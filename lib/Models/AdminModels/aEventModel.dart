class EventModel {
  // variables
  final String title;
  final String description;
  final String eventDate;
  final String location;
  final String eventStatus;
  final String documentUrl;

  EventModel({required this.title, required this.description, required this.eventDate, required this.location, required this.eventStatus, required this.documentUrl});

  Map<String, dynamic> toMap() {
    return {
      'title':title,
      'description':description,
      'eventDate':eventDate,
      'location':location,
      'eventStatus':eventStatus,
      'documentUrl':documentUrl
    };
  }

  factory EventModel.fromMap(Map<String, dynamic>map) {
    return EventModel(
        title: map['title'],
        description: map['description'],
        eventDate: map['eventDate'],
        location: map['location'],
        eventStatus: map['eventStatus'],
      documentUrl: map['documentUrl']
    );
  }
}