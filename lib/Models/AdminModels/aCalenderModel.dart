class CalenderModel{
  final String calenderDate;
  final String eventTitle;
  final String eventType;

  CalenderModel({required this.calenderDate, required this.eventTitle, required this.eventType});

  Map<String, dynamic> toMap(){
    return{
      'calenderDate': calenderDate,
      'eventTitle': eventTitle,
      'eventType': eventType
    };
  }

  factory CalenderModel.fromMap(Map<String, dynamic> map){
    return CalenderModel(
        calenderDate: map['calenderDate'],
        eventTitle: map['eventTitle'],
        eventType: map['eventType']
    );
  }
}