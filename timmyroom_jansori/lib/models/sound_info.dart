class SoundInfo {
  int id;

  SoundInfo({this.id});

  fromMap(Map<String, dynamic> json) => SoundInfo(
    id: json["id"]
  );

  Map<String, dynamic> toMap() => {
    "id": id
  };
}