const TodoTable = "Todo";
const ColumnId = "id";
const ColumnTitle = "title";
const ColumnDateTime = "dateTime";
const ColumnBody = "body";
const ColumnStatus = "status";

class TodoModel {
  String? title;
  String? dateTime;
  String? body;
  int? id;
  bool? status;

  TodoModel({this.body, this.dateTime, this.title, this.id, this.status});

  TodoModel.fromDatabase(Map map) {
    id = map["id"];
    title = map["title"];
    body = map["body"];
    dateTime = map["dateTime"];
    status = map["status"] == 1 ? true : false;
  }
}
