class InboxModel{

  final String title;
  final String email;
  final String details;
  final int id;

  InboxModel({required this.title,required this.email,required this.details,required this.id});


  static List<InboxModel> inboxList = [
    InboxModel(title: 'Title 1', email: "exp2@example.com", details: "Details", id: 1,),
    InboxModel(title: 'Title 2', email: "exp3@example.com", details: "Details", id: 2,),
    InboxModel(title: 'Title 3', email: "exp4@example.com", details: "Details", id: 3,),
    InboxModel(title: 'Title 4', email: "exp5@example.com", details: "Details", id: 4,),
  ];

}