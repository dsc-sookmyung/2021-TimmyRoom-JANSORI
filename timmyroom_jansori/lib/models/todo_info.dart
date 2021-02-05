class ToDoInfo {
  int id;
  String name; // 할일 제목
  int duringTime; // 집중 시간 ?
  int restTime; // 휴식시간
  int isOn; // 알람켜졌냐
  bool isDuringStart; // 시작했냐
  bool isDuringEnd; // 끝났냐
  bool isRestStart; //
  bool isRestEnd; // 

  ToDoInfo(
      {this.id,
        this.name,
        this.duringTime,
        this.restTime,
        this.isOn,
      }
  );

  factory ToDoInfo.fromMap(Map<String, dynamic> json) => ToDoInfo(
    id: json["id"],
    name: json["name"],
    duringTime: json["duringTime"],
    restTime: json["restTime"],
    isOn: json["isOn"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "duringTime": duringTime,
    "restTime": restTime,
    "isOn": isOn,
  };
}

