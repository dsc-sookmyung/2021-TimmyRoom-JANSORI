class SoundInfo {
  int id;
  String path;

  SoundInfo({this.id, this.path});

  fromMap(Map<String, dynamic> json) => SoundInfo(
    id: json["id"],
    path: json["path"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "path" : path
  };
}